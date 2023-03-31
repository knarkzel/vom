module vom

// Parser which returns a single value
pub type Fn = fn (string) !(string, string)

// Parser which returns many values
pub type FnMany = fn (string) !(string, []string)

pub type FnCount = fn (string) !(string, usize)

pub type FnResult = fn (string) !(string, []string, string)

// Core parser type
pub type Parser = Fn | FnCount | FnMany | FnResult
