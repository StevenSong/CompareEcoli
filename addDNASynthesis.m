function [new_model, new_rxn] = addDNASynthesis(model)
    new_rxn = 'Sink DNA Synthesis';
    new_model = addReaction(model, new_rxn, 'metaboliteList', {'datp_c', 'dttp_c', 'dgtp_c', 'dctp_c'}, 'stoichCoeffList', [-1,-1,-1,-1], 'reversible', false, 'printLevel', 0);
end

