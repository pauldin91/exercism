
/// Check a Luhn checksum.
pub fn is_valid(code: &str) -> bool {
    let sanitized = code.trim_start().trim_end();
    if sanitized.len() < 1 || sanitized=="0"
        || sanitized
            .chars()
            .any(|c| !(c.is_digit(10) || c.is_whitespace()))
    {
        return false;
    }

    let chunks: Vec<&str> = sanitized.split(" ").collect();
    let san = chunks.join("");

    let trans: Vec<u32> = san
        .chars()
        .rev()
        .enumerate()
        .map(|(k, v)| {
            let res = v.to_digit(10).unwrap();
            if k % 2 == 1 {
                let d = res * 2;
                if d > 9 { d - 9 } else { d }
            } else {
                res
            }
        })
        .collect();

    

    let res: u32 = trans.into_iter().sum();

    res % 10 == 0
}
