function [new_model, new_rxn] = addProteinSynthesis(model)
    new_rxn = 'Sink Protein Synthesis';
    new_model = addReaction(model, new_rxn, 'metaboliteList', {'ala__L_c', 'arg__L_c', 'asn__L_c', 'asp__L_c', 'cys__L_c', 'gln__L_c', 'glu__L_c', 'gly_c', 'his__L_c', 'ile__L_c', 'leu__L_c', 'lys__L_c', 'met__L_c', 'phe__L_c', 'pro__L_c', 'ser__L_c', 'thr__L_c', 'trp__L_c', 'tyr__L_c', 'val__L_c'}, 'stoichCoeffList', [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1], 'reversible', false, 'printLevel', 0);
end

