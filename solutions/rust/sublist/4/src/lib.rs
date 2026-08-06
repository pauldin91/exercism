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
    let mut start = 0;
    if l1 == 0 && l2 == 0 {
        return Comparison::Equal;
    } else if l1 == 0 && l2 > 0 {
        return Comparison::Sublist;
    } else if l2 == 0 && l1 > 0 {
        return Comparison::Superlist;
    }

    if l1 < l2 {
        j = find_next(second_list, 0, &first_list[0]);
        start = j;
    } else {
        i = find_next(first_list, 0, &second_list[0]);
        start = i;
    }

    if i < 0 || j < 0 {
        return Comparison::Unequal;
    }
    while i < l1 as i32 && j < l2 as i32 {
        if first_list[i as usize] == second_list[j as usize] {
            count_found += 1;
            i += 1;
            j += 1;
        } else if l1 <= l2 {
            start += 1;
            i = 0;
            j = find_next(&second_list, start, &first_list[0]);
            count_found = 0;
        } else if l2 < l1 {
            start += 1;
            j = 0;
            i = find_next(&first_list, start, &second_list[0]);
            count_found = 0;
        }
        if i < 0 || j < 0 {
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

fn find_next(array: &[i32], start_at: i32, num: &i32) -> i32 {
    let mut k = start_at;
    while k < array.len() as i32 {
        if array[k as usize] == *num {
            return k;
        }
        k += 1;
    }
    return -1;
}
