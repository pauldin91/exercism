pub fn brackets_are_balanced(string: &str) -> bool {
    let mut stack = Vec::new();

    for c in string.chars() {
        if c == '{' || c == '[' || c == '(' {
            stack.push(c);
        } else if c == '}' || c == ']' || c == ')' {
            let op = stack.last();
            if op.is_some() && opposite(op.unwrap()) == c && !stack.is_empty() {
                stack.pop();
            } else {
                return false;
            }
        }
    }

    return stack.is_empty();
}

fn opposite(bracket: &char) -> char {
    match bracket {
        '{' => '}',
        '[' => ']',
        '(' => ')',
        '}' => '{',
        ']' => '[',
        ')' => '(',
        _ => '\0',
    }
}
