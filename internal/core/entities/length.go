package entities

import (
	"fmt"
	"gopkg.in/yaml.v3"
	"regexp"
	"strconv"
)

type Length int64

const (
	Nanometer  Length = 1
	Micrometer        = 1000 * Nanometer
	Millimeter        = 1000 * Micrometer
	Centimeter        = 10 * Millimeter
	Inch              = 25400 * Micrometer
)

var _ yaml.Unmarshaler = (*Length)(nil)

var lengthPattern = regexp.MustCompile(`^(\d+(?:[.,]\d+)?)(mm|cm|in)$`)

var (
	ErrNotAString       = fmt.Errorf("not a string")
	ErrBadPattern       = fmt.Errorf("bad pattern")
	ErrUnknownDimension = fmt.Errorf("unknown dimension")
)

//goland:noinspection GoMixedReceiverTypes
func (r *Length) UnmarshalYAML(value *yaml.Node) error {
	if value.Tag != "!!str" {
		return fmt.Errorf("%w: %s", ErrNotAString, value.Tag)
	}

	if !lengthPattern.MatchString(value.Value) {
		return fmt.Errorf("%w: %s: want <length><dimension>, e.g.: 12.34mm", ErrBadPattern, value.Value)
	}

	matches := lengthPattern.FindAllStringSubmatch(value.Value, -1)[0]
	_, length, stringDimension := matches[0], matches[1], matches[2]

	dimension, err := dimensionToLength(stringDimension)
	if err != nil {
		return fmt.Errorf("dimension to length: %w", err)
	}

	float, err := strconv.ParseFloat(length, 64)
	if err != nil {
		return fmt.Errorf("parse float: %w", err)
	}

	*r = Length(float) * dimension

	return nil
}

//goland:noinspection GoMixedReceiverTypes
func (r Length) String() string {
	return fmt.Sprintf("%fmm", float64(r)/float64(Millimeter))
}

func dimensionToLength(dimension string) (Length, error) {
	switch dimension {
	case "mm":
		return Millimeter, nil
	case "cm":
		return Centimeter, nil
	case "in":
		return Inch, nil
	default:
		return 0, fmt.Errorf("%w: %s", ErrUnknownDimension, dimension)
	}
}
