function [results, maxes] = evalDNAProteinSynthesis()
    % Download models
    system('python get_models.py coli');
    model_files = dir('models/*.mat');
    model_files = {model_files.name};
    for i = length(model_files):-1:1
        models(i) = struct2cell(load('models/' + string(model_files(i))));
    end

    % biomass_rxn = 'BIOMASS_Ec_iJO1366_core_53p95M';
    feed_rxn = 'EX_glc__D_e';
    feed_lb = -10;
    
    for i = length(models):-1:1
        model_name = split(model_files(i), '.');
        model_name = model_name(1);
        results(i).model = model_name;
        fprintf("Evaluating %d: %s\n", i, string(model_name));
        model = cell2mat(models(i));
        
        % Biomass
        [rxn_idxs, rxns] = findRxn(model, "biomass core", false);
        if isempty(rxn_idxs)
            [rxn_idxs, rxns] = findRxn(model, "biomass", false);
            if isempty(rxn_idxs)
                fprintf("No biomass core reaction found!\n");
                continue;
            end
        end
        biomass_rxn = char(rxns(1));
        model = fixModel(model);
        max_biomass = findMaxBiomass(model, feed_rxn, feed_lb, biomass_rxn);
        results(i).max_biomass = max_biomass;
        
        % DNA Synthesis
        model = fixModel(model);
        model = changeRxnBounds(model, feed_rxn, feed_lb, 'l');
        model = changeRxnBounds(model, biomass_rxn, max_biomass * 0.5, 'b');
        [model, dna_synthesis_rxn] = addDNASynthesis(model);
        model = changeObjective(model, dna_synthesis_rxn);
        FBA = optimizeCbModel(model);
        results(i).max_dna_synthesis = FBA.obj;
        
        % Protein Synthesis
        model = fixModel(model);
        model = changeRxnBounds(model, feed_rxn, feed_lb, 'l');
        model = changeRxnBounds(model, biomass_rxn, max_biomass * 0.5, 'b');
        [model, protein_synthesis_rxn] = addProteinSynthesis(model);
        model = changeObjective(model, protein_synthesis_rxn);
        FBA = optimizeCbModel(model);
        results(i).max_protein_synthesis = FBA.obj;        
    end
    
    [maxes.fluxes, maxes.idxs] = maxk([results.max_biomass; results.max_dna_synthesis; results.max_protein_synthesis]', 5, 1);
end

