package parallelletterfrequency

import (
	"strings"
	"sync"
	"unicode"
)

// FreqMap records the frequency of each rune in a given text.
type FreqMap map[rune]int

// Frequency counts the frequency of each rune in a given text and returns this
// data as a FreqMap.
func Frequency(text string) FreqMap {
	var res FreqMap = FreqMap{}
	for _, c := range strings.ToLower(strings.Replace(text, " ", "", -1)) {
		if unicode.IsLetter(c) {
			res[c]++
		}
	}
	return res
}
func Merge(m1, m2 FreqMap) FreqMap {
	for k, v := range m1 {
		if unicode.IsLetter(k) {
			m2[k] += v
		}
	}
	return m2
}

// ConcurrentFrequency counts the frequency of each rune in the given strings,
// by making use of concurrency.
func ConcurrentFrequency(texts []string) FreqMap {

	var group = make(chan FreqMap, len(texts))
	var total = FreqMap{}
	var wg sync.WaitGroup
	for _, l := range texts {
		wg.Add(1)
		go func(line string) {
			defer wg.Done()
			group <- Frequency(line)
		}(l)
	}
	wg.Wait()
	close(group)

	for m := range group {
		total = Merge(m, total)
	}
	return total
}
