function fixed = fixModel(model)
    if (size(model.csense, 2) ~= 1)
        model.csense = model.csense';
    end
    fixed = model;
end

