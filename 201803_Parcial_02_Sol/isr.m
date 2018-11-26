function impuesto = isr(x,TarifaISR)
  cat = find(TarifaISR.LimInf <= x , 1, 'last' );
  impuesto = TarifaISR.CuotaFija(cat) + ...
             0.01*TarifaISR.porcExcedente(cat)*(x-TarifaISR.LimInf(cat));
end