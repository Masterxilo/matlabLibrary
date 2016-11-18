assert(isfunction_handle(@sin));
assert(isfunction_handle(@(x) x));
assert(~isfunction_handle(0));