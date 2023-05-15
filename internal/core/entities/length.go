package entities

import (
	"fmt"
	"gopkg.in/yaml.v3"
	"math"
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

	HFill           Length = math.MaxInt64
	HFil            Length = math.MaxInt64 - 1
	VFill           Length = math.MaxInt64 - 2
	VFil            Length = math.MaxInt64 - 3
	RemainingHeight Length = math.MaxInt64 - 4
)

var _ yaml.Unmarshaler = (*Length)(nil)

var lengthPattern = regexp.MustCompile(`^(?:hfill|hfil|vfill|vfil|remaining height|(\d+(?:[.,]\d+)?)(mm|cm|in))$`)

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

	switch value.Value {
	case "hfill":
		*r = HFill
		return nil

	case "hfil":
		*r = HFil
		return nil

	case "vfill":
		*r = VFill
		return nil

	case "vfil":
		*r = VFil
		return nil

	case "remaining height":
		*r = RemainingHeight
		return nil
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
	if r == HFill {
		return `\hfill{}`
	}

	if r == HFil {
		return `\hfil{}`
	}

	if r == VFill {
		return `\vfill{}`
	}

	if r == VFil {
		return `\vfil{}`
	}

	if r == RemainingHeight {
		return `\remainingHeight{}`
	}

	return fmt.Sprintf("%fmm", float64(r)/float64(Millimeter))
}

func (r *Length) IsSpecial() bool {
	if r == nil {
		return false
	}

	return *r == HFill || *r == HFil || *r == VFill || *r == VFil || *r == RemainingHeight
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
