  SELECT q_id AS id,
    q_nome as nome_acao_governo,
    sdo_util.to_wkbgeometry(sdo_geom.sdo_centroid (tb_regiao_mapas.geometry,2)) geom
  FROM(   
    SELECT   
      distinct mag_acao_governo.id_acao_governo as q_id, 
      mag_acao_governo.nome_acao_governo as q_nome, 
       mag_localidade_acao.TIPO_LOCALIDADE_ACAO_GOVERNO as q_tipo,
       spm_regiao_planejamento.id_regiao_planej as q_regiao
  FROM mag_acao_governo
  LEFT JOIN mag_localidade_acao
    ON mag_acao_governo.id_acao_governo = mag_localidade_acao.id_acao_governo
  LEFT JOIN spm_regiao_planejamento
    ON spm_regiao_planejamento.id_regiao_planej = mag_localidade_acao.id_regiao_planej
  WHERE  spf_situacao_cons_acao(mag_acao_governo.id_acao_governo) is not null 
  AND spf_situacao_cons_acao(mag_acao_governo.id_acao_governo) = __f_tipo__
  AND mag_localidade_acao.TIPO_LOCALIDADE_ACAO_GOVERNO = 1)
  LEFT JOIN tb_regiao_mapas 
    ON q_regiao = tb_regiao_mapas.id_regiao
  