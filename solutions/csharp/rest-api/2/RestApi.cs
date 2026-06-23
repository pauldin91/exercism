using System.Collections.Concurrent;
using System.Text.Json;
using System.Text.Json.Serialization;

public class User
{
    [JsonPropertyName("name")] public string Name { get; set; }
    [JsonPropertyName("owes")] public SortedDictionary<string, int> Owes { get; set; }

    [JsonPropertyName("owed_by")] public SortedDictionary<string, int> OwedBy { get; set; }

    [JsonPropertyName("balance")] public int Balance { get; set; }
}

public record CreateUserRequest([property: JsonPropertyName("user")] string Name);

public record UserRequest(
    [property: JsonPropertyName("users")] HashSet<string> Users
);

public record IoURequest(
    [property: JsonPropertyName("lender")] string Lender,
    [property: JsonPropertyName("borrower")]
    string Borrower,
    [property: JsonPropertyName("amount")] int Amount
);
public class RestApi
{
    private readonly Dictionary<string, User> _users = new();

    public RestApi(string database)
    {
        var users = JsonSerializer.Deserialize<List<User>>(database) ?? [];
        users.ForEach(s => _users.TryAdd(s.Name, s));
    }

    public string Get(string url, string? payload = null)
    {
        var req = payload == null ? new UserRequest(new()) : JsonSerializer.Deserialize<UserRequest>(payload ?? "");

        var result = _users.Where(s => req.Users.Contains(s.Key))
            .Select(s => s.Value).ToList();
        return JsonSerializer.Serialize(result);
    }

    public string Post(string url, string payload)
    {
        if (url.CompareTo("/iou", StringComparison.OrdinalIgnoreCase) == 0)
        {
            var iou = JsonSerializer.Deserialize<IoURequest>(payload)!;
            UpdateBorrowersAndLenders(iou);
            return JsonSerializer.Serialize(_users
                .Where(s => s.Value.Name == iou.Borrower || s.Value.Name == iou.Lender)
                .Select(s => s.Value)
                .ToList());
        }

        if (url.CompareTo("/add", StringComparison.OrdinalIgnoreCase) == 0)
        {
            var addUser = JsonSerializer.Deserialize<CreateUserRequest>(payload)!;
            var user = new User
            {
                Name = addUser.Name,
                Owes = new(),
                OwedBy = new(),
                Balance = CalculateBalance(addUser.Name)
            };
            _users.TryAdd(user.Name, user);
            return JsonSerializer.Serialize(user);
        }

        return payload;
    }


    private void UpdateBorrowersAndLenders(IoURequest iou)
    {
        var lenderExists = _users.TryGetValue(iou.Lender, out var lender);
        var borrowerExists = _users.TryGetValue(iou.Borrower, out var borrower);
        if (lenderExists && borrowerExists)
        {
            UpdateUsers(lender, borrower, iou.Amount);
            _users[lender.Name] = lender;
            _users[borrower.Name] = borrower;
            _users[lender.Name].Balance = CalculateBalance(lender.Name);
            _users[borrower.Name].Balance = CalculateBalance(borrower.Name);
        }
        
    }

    private void UpdateUsers(User lender, User borrower, int amount)
    {
        if (lender.Owes.TryGetValue(borrower.Name, out var borrowed))
        {
            if (borrowed < amount)
            {
                lender.Owes.Remove(borrower.Name);
                borrower.OwedBy.Remove(lender.Name);
                lender.OwedBy[borrower.Name] = amount - borrowed;
                borrower.Owes[lender.Name] = amount - borrowed;
            }
            else if (borrowed > amount)
            {
                lender.Owes[borrower.Name] = borrowed - amount;
                borrower.OwedBy[lender.Name] = borrowed - amount;
            }
            else
            {
                lender.Owes.Remove(borrower.Name);
                borrower.OwedBy.Remove(lender.Name);
            }
        }
        else
        {
            lender.OwedBy[borrower.Name] = amount;
            borrower.Owes[lender.Name] = amount;
        }
    }


    private int CalculateBalance(string usernmae)
    {
        int balance = 0;
        _ = _users.TryGetValue(usernmae, out var user);
        foreach (var item in user?.OwedBy ?? [])
        {
            balance += item.Value;
        }


        foreach (var item in user?.Owes ?? [])
        {
            balance -= item.Value;
        }

        return balance;
    }
}