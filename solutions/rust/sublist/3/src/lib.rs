use std::collections::HashMap;

#[derive(Debug, PartialEq, Eq)]
pub enum Comparison {
    Equal,
    Sublist,
    Superlist,
    Unequal,
}

pub fn sublist(first_list: &[i32], second_list: &[i32]) -> Comparison {
    let mut i = 0;
    let mut j = 0;
    let l1 = first_list.len();
    let l2 = second_list.len();
    let mut count_found = 0;
    if l1 == 0 && l2 == 0 {
        return Comparison::Equal;
    } else if l1 == 0 && l2 > 0 {
        return Comparison::Sublist;
    } else if l2 == 0 && l1 > 0 {
        return Comparison::Superlist;
    }

    if l1 < l2 {
        while second_list[j] != first_list[0] && j < l2 {
            j += 1;
        }
    } else {
        while first_list[i] != second_list[0] && i < l1 {
            i += 1;
        }
    }
    while i < l1 && j < l2 {
        if first_list[i] == second_list[j] {
            count_found += 1;
            i += 1;
            j += 1;
        } else {
            break;
        }
    }

    if count_found == l1 && l1 == l2 {
        return Comparison::Equal;
    } else if count_found == l1 {
        return Comparison::Sublist;
    } else if count_found == l2 {
        return Comparison::Superlist;
    }
    Comparison::Unequal
}
