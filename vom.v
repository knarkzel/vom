module vom

// Parser which returns a single value
pub type Fn = fn (string) !(string, string, int)

// Parser which returns many values
pub type FnMany = fn (string) !(string, []string, int)

pub type FnCount = fn (string) !(string, usize, int)

pub type FnResult = fn (string) !(string, []string, string, int)

// Core parser type
pub type Parser = Fn | FnCount | FnMany | FnResult
