package entities

type Files []File

func (r Files) IsEmpty() bool {
	return len(r) == 0
}

type File struct {
	Name     string
	Contents []byte
}

func (r File) IsEmpty() bool {
	return len(r.Name) == 0 && len(r.Contents) == 0
}
