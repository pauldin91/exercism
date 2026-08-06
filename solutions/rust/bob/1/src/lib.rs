pub fn reply(message: &str) -> &str {
    let yell = message.to_uppercase().eq(message)
        && message
            .chars()
            .into_iter()
            .filter(|&c| c.is_alphabetic() && !c.is_digit(10))
            .count()
            > 0;
    let ask = message.trim_start().trim_end().ends_with("?");

    if message.trim_start().trim_end().is_empty() {
        return "Fine. Be that way!";
    } else if yell & ask {
        return "Calm down, I know what I'm doing!";
    } else if ask {
        return "Sure.";
    } else if yell {
        return "Whoa, chill out!";
    } else {
        return "Whatever.";
    }
}
