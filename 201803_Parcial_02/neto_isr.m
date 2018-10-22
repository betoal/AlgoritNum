function monto_neto =  neto_isr(x,TarifaISR)
   monto_neto = x - isr(x,TarifaISR);
end

