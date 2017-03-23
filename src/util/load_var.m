% Load variable from file
function data = load_var(file, var)
	temp = load(file, var);
	data = temp.(var);
end
