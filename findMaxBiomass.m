function maxBiomass = findMaxBiomass(model, feed_rxn, feed_lb, biomass_rxn)
    model = changeRxnBounds(model, {feed_rxn}, feed_lb, 'l');
    model = changeObjective(model, {biomass_rxn});
    FBA = optimizeCbModel(model);
    maxBiomass = FBA.obj;
end