
CREATE OR REPLACE FUNCTION public.inseremarcacao(autenticacao int, tipo integer, urlpic text)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
      begin
	      
	      insert into fotos (url) values (urlpic);
	     
	      insert into controle(id_pessoa, tipo_marcacao, tipo_marcacao_desc, metodo, id_foto)
	      select p.id_pessoa as id_pessoa, 
	      tipo as tipo_marcacao, 
	      case 
		  when tipo = 0 then 'entrada'
	      when tipo = 1 then 'saida'
	      end as tipo_marcacao_desc,
	      case 
		  when autenticacao = p.senha then 0
		  when autenticacao = p.rf_cartao then 1
	      end as metodo,
	      (select id_foto from fotos where url = urlpic) as id_foto
	      from pessoas as p
	      where senha = autenticacao or rf_cartao = autenticacao;
	      
	      
      END;
      $function$
;