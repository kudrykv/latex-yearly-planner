package entities

import (
	"fmt"
	"gopkg.in/yaml.v3"
)

type Placement string

const (
	PlacementTop    Placement = "top"
	PlacementBottom Placement = "bottom"
	PlacementLeft   Placement = "left"
	PlacementRight  Placement = "right"
)

var ErrInvalidPlacement = fmt.Errorf("invalid placement")

func (r *Placement) UnmarshalYAML(value *yaml.Node) error {
	if value.Tag != "!!str" {
		return ErrNotAString
	}

	switch value.Value {
	case "top":
		*r = PlacementTop
	case "bottom":
		*r = PlacementBottom
	case "left":
		*r = PlacementLeft
	case "right":
		*r = PlacementRight
	default:
		return ErrInvalidPlacement
	}

	return nil
}
