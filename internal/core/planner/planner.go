package planner

type Planner struct{}

func New() Planner {
	return Planner{}
}

func (r *Planner) Generate() error {
	panic("not implemented")
}

func (r *Planner) Write() error {
	panic("not implemented")
}

func (r *Planner) Compile() error {
	panic("not implemented")
}
