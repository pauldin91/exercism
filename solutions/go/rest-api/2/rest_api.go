package restapi

// Define the Rest API interface. You should not modify the code in this block.

type User struct {
	Name    string
	Owes    map[string]float64
	OwedBy  map[string]float64
	Balance float64
}

type GetUsersRequest struct {
	Users []string
}

type GetUsersResponse struct {
	Users []User
}

type AddUserRequest struct {
	User string
}

type AddUserResponse struct {
	User User
}

type AddIouRequest struct {
	Lender   string
	Borrower string
	Amount   float64
}

type AddIouResponse struct {
	Users []User
}

type RestApi interface {
	GetUsers(GetUsersRequest) GetUsersResponse
	AddUser(AddUserRequest) AddUserResponse
	AddIou(AddIouRequest) AddIouResponse
}

// Your code goes below here. Implement the RestApi interface.

type Api struct {
	db map[string]User
}

func NewApi(database []User) RestApi {
	result := make(map[string]User)
	for _, u := range database {
		result[u.Name] = u
	}
	return &Api{
		db: result,
	}
}

func (a *Api) GetUsers(req GetUsersRequest) GetUsersResponse {
	var result = make([]User, 0)
	for _, u := range req.Users {
		if user, ok := a.db[u]; ok {
			result = append(result, user)
		}
	}
	return GetUsersResponse{result}
}

func (a *Api) AddUser(req AddUserRequest) AddUserResponse {
	if _, ok := a.db[req.User]; !ok {
		a.db[req.User] = User{
			Name:    req.User,
			Owes:    make(map[string]float64),
			OwedBy:  make(map[string]float64),
			Balance: 0.0,
		}
	}
	return AddUserResponse{a.db[req.User]}
}
func calculateBalance(user *User) {
	user.Balance = 0
	for _, a := range user.OwedBy {
		user.Balance += a
	}
	for _, a := range user.Owes {
		user.Balance -= a
	}
}

func (a *Api) update(req AddIouRequest) (User, User) {
	lender := a.db[req.Lender]
	borrower := a.db[req.Borrower]

	if lenderOwesBack, ok := lender.Owes[req.Borrower]; ok {
		if lenderOwesBack > req.Amount {
			lender.Owes[req.Borrower] = lenderOwesBack - req.Amount
			borrower.OwedBy[req.Lender] = lender.Owes[req.Borrower]
			delete(lender.OwedBy, req.Borrower)
			delete(borrower.Owes, req.Lender)
		} else if lenderOwesBack < req.Amount {

			delete(lender.Owes, req.Borrower)
			delete(borrower.OwedBy, req.Lender)

			lender.OwedBy[req.Borrower] = req.Amount - lenderOwesBack
			borrower.Owes[req.Lender] = req.Amount - lenderOwesBack
		} else {
			delete(lender.Owes, req.Borrower)
			delete(borrower.OwedBy, req.Lender)
		}
	} else if req.Amount > 0 {
		lender.OwedBy[req.Borrower] = req.Amount
		borrower.Owes[req.Lender] = req.Amount
	}
	calculateBalance(&lender)
	calculateBalance(&borrower)

	a.db[req.Lender] = lender
	a.db[req.Borrower] = borrower

	return lender, borrower

}

func (a *Api) AddIou(req AddIouRequest) AddIouResponse {
	lender, borrower := a.update(req)
	users := make([]User, 0)
	if req.Borrower < req.Lender {
		users = append(users, borrower)
		users = append(users, lender)
	} else {
		users = append(users, lender)
		users = append(users, borrower)

	}
	return AddIouResponse{Users: users}

}
