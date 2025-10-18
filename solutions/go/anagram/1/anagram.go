package anagram

import (
	"sort"
	"strings"
)

func Detect(subject string, candidates []string) []string {
	parts := strings.Split(strings.ToLower(subject), "")
	sort.Strings(parts)
	sorted := strings.Join(parts, "")
	res := make([]string, 0)
	for _, c := range candidates {
		parts := strings.Split(strings.ToLower(c), "")
		sort.Strings(parts)
		if sorted == strings.Join(parts, "") && strings.ToLower(c) != strings.ToLower(subject) {
			res = append(res, c)
		}
	}
	return res
}
