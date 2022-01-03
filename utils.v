module vom

// Parser which returns a single value
pub type Fn = fn (string) ?(string, string)

// Parser which returns many values
pub type FnMany = fn (string) ?(string, []string)
