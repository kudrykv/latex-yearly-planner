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
	LineWidth       Length = math.MaxInt64 - 5
)

var _ yaml.Unmarshaler = (*Length)(nil)

var lengthPattern = regexp.MustCompile(`^(?:hfill|hfil|vfill|vfil|remaining height|line width|(\d+(?:[.,]\d+)?)(mm|cm|in))$`)

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

	case "line width":
		*r = LineWidth
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

	*r = Length(float * float64(dimension))

	return nil
}

//goland:noinspection GoMixedReceiverTypes
func (r Length) String() string {
	switch r {
	case HFill:
		return `\hfill`
	case HFil:
		return `\hfil`
	case VFill:
		return `\vfill`
	case VFil:
		return `\vfil`
	case RemainingHeight:
		return `\remainingHeight`
	case LineWidth:
		return `\linewidth`
	}

	return fmt.Sprintf("%fmm", float64(r)/float64(Millimeter))
}

func (r *Length) IsSpecial() bool {
	if r == nil {
		return false
	}

	return *r == HFill || *r == HFil || *r == VFill || *r == VFil || *r == RemainingHeight || *r == LineWidth
}

func (r *Length) IsZero() bool {
	if r == nil {
		return true
	}

	return *r == 0
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
