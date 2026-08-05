use std::collections::HashMap;

#[derive(Debug, PartialEq, Eq)]
pub enum Comparison {
    Equal,
    Sublist,
    Superlist,
    Unequal,
}

pub fn sublist(first_list: &[i32], second_list: &[i32]) -> Comparison {
    let l1 = first_list.len();
    let l2 = second_list.len();
    let mut map = HashMap::<i32, usize>::new();

    for value in first_list {
        *map.entry(*value).or_insert(0) += 1;
    }
    let mut count_found = 0;
    for value in second_list {
        if let Some(s) = map.get(&value)
            && *s > 0
        {
            count_found += 1;
            *map.get_mut(&*value).unwrap() -= 1;
        }
    }

    if count_found == l1 && l1 == l2 {
        return Comparison::Equal;
    }else if count_found == l1{
        return Comparison::Sublist;
    } else if count_found == l2{
        return Comparison::Superlist;
    }
    Comparison::Unequal
}
