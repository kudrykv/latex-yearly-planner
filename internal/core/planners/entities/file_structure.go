package entities

type FileStructure struct {
	Index File
	Files Files
}

func (r FileStructure) IsEmpty() bool {
	return r.Index.IsEmpty() && r.Files.IsEmpty()
}
