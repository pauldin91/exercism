use std::collections::HashSet;

pub fn sum_of_multiples(limit: u32, factors: &[u32]) -> u32 {

    let mut result = HashSet::<u32>::new();
    for f in factors.into_iter().filter(|s|**s > 0 ){
        add_factor(&mut result,&f, limit);
    }
    result.iter().sum()
}

fn add_factor(set: &mut HashSet<u32>,factor: &u32,limit: u32){
    let mut current=*factor;
    loop {
        if limit<= current {
            break;
        }
        if current%factor==0{
            set.insert(current);
        }
        current+=1;
    }
    
}
