package reversestring

func Reverse(input string) string {
	return string(doReverse([]rune(input), make([]rune,0)))
}

func doReverse(input []rune, reverse []rune) []rune {

	if len(input) == 0 {
		return reverse
	} else if len(input) == 1 {
		return append(reverse , input...)
	}
	return doReverse(input[:len(input)-1], append(reverse,rune(input[len(input)-1])))
}
