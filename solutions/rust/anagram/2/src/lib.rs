use std::collections::{HashMap,HashSet};


fn letter_frequencies(word: &str) -> HashMap<char, usize> {
    let mut freq = HashMap::new();

    for c in word.to_lowercase().chars() {
        *freq.entry(c).or_insert(0) += 1;
    }

    freq
}


fn is_anagram_of(word: &str, candidate: &str) -> bool {
    let lower_word = word.to_lowercase();
    let lower_canditate = candidate.to_lowercase();
    letter_frequencies(&lower_word) == letter_frequencies(&lower_canditate) && !lower_word.eq(&lower_canditate)
}



pub fn anagrams_for<'a>(word: &'a str, possible_anagrams: &'a [&str]) -> HashSet<&'a str> {
    let mut result = HashSet::<&'a str>::new();


    for pos in possible_anagrams {
        if is_anagram_of(word, &pos) {
            result.insert(&pos);
        }
    }

    result
}