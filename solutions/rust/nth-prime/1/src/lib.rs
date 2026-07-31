pub fn nth(n: u32) -> u32 {
    let mut k = 0;
    let mut i = 2;
    loop {
        if is_prime(i) {
            if k == n {
                return i;
            }
            k += 1;
        }
        i += 1;
    }
}

pub fn is_prime(n: u32) -> bool {
    let mut k: u32 = 2;
    while (k as f32) <= (n as f32).sqrt() {
        if n.is_multiple_of(k) && n != k {
            return false;
        }
        k += 1;
    }
    return true && n >= 2;
}
