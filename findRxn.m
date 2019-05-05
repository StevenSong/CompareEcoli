function [rxn_idxs, rxns] = findRxn(model, rxnName, verbose)
    rxnName = split(rxnName);
    rxn_idxs = [];
    rxns = [];
    for i = 1 : length(model.rxns)
        curr = string(model.rxns(i));
        
        matches = true;
        for j = 1 : length(rxnName)
            matches = matches && contains(curr, rxnName(j), 'IgnoreCase', true);
        end
        
        if matches
            if verbose
                fprintf("%d: %s\n", i, curr);
            end
            rxn_idxs = [rxn_idxs i];
            rxns = [rxns curr];
        end
    end
end

