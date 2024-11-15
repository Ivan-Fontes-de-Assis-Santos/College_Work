-- Gerado por Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   em:        2024-09-16 21:07:39 BRT
--   site:      Oracle Database 21c
--   tipo:      Oracle Database 21c



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE mc_categoria_produto (
    cd_categoria NUMBER NOT NULL,
    descricao    VARCHAR2(255),
    status       CHAR(1),
    data_inicio  DATE
);

ALTER TABLE mc_categoria_produto ADD CONSTRAINT categoria_produto_pk PRIMARY KEY ( cd_categoria );

CREATE TABLE mc_cli_fisica (
    id_cliente            NUMBER(5) NOT NULL,
    cd_fisica             NUMBER NOT NULL,
    dt_nasc               DATE,
    sx_biologico          CHAR(1),
    genero_nasc           VARCHAR2(50),
    nr_cpf                CHAR(11),
    mc_cliente_id_cliente NUMBER(5) NOT NULL
);

ALTER TABLE mc_cli_fisica ADD CONSTRAINT mc_cli_fisica_pk PRIMARY KEY ( id_cliente,
                                                                        cd_fisica );

CREATE TABLE mc_cli_juridica (
    id_cliente            NUMBER(5) NOT NULL,
    cd_juridico           NUMBER NOT NULL,
    dt_fundacao           DATE,
    nr_cnpj               VARCHAR2(14),
    insc_estadual         VARCHAR2(12),
    mc_cliente_id_cliente NUMBER(5) NOT NULL
);

ALTER TABLE mc_cli_juridica ADD CONSTRAINT mc_cli_juridica_pk PRIMARY KEY ( id_cliente,
                                                                            cd_juridico );

CREATE TABLE mc_cliente (
    id_cliente     NUMBER(5) NOT NULL,
    nome           VARCHAR2(255),
    qt_estrelas    NUMBER,
    status_cliente CHAR(1),
    login          VARCHAR2(50),
    senha          VARCHAR2(50),
    tp_cliente     CHAR(1),
    cd_juridico    NUMBER NOT NULL,
    cd_fisica      NUMBER NOT NULL,
    dt_nasc        DATE
);

ALTER TABLE mc_cliente ADD CONSTRAINT mc_cliente_pk PRIMARY KEY ( id_cliente );

CREATE TABLE mc_funcionario (
    cd_funcionario    NUMBER NOT NULL,
    nome              VARCHAR2(255),
    cpf               CHAR(11) NOT NULL,
    data_nascimento   DATE,
    telefone          VARCHAR2(15),
    email             VARCHAR2(255),
    cargo             VARCHAR2(100),
    nome_departamento VARCHAR2(100)
);

ALTER TABLE mc_funcionario ADD CONSTRAINT funcionario_pk PRIMARY KEY ( cd_funcionario );

CREATE TABLE MC_SGV_SAC (
    cd_sac NUMBER NOT NULL,
    id_cliente NUMBER NOT NULL,
    cd_produto NUMBER NOT NULL,
    cd_funcionario NUMBER NOT NULL,
    descricao_chamado CLOB,
    data_abertura DATE,
    data_atendimento DATE,
    duracao_total_minutos NUMBER,
    descricao_retorno CLOB,
    tipo_chamado CHAR(1),
    status CHAR(a),
    indice_satisfacao NUMBER(1, 100),
    mc_cliente_id_cliente NUMBER(5) NOT NULL,
    mc_funcionario_cd_funcionario NUMBER NOT NULL,
    produto_cd_produto NUMBER NOT NULL
) 
;

ALTER TABLE mc_sgv_sac ADD CONSTRAINT sac_pk PRIMARY KEY ( cd_sac );

CREATE TABLE mc_vd_class (
    cd_classificacao CHAR(3) NOT NULL,
    sg_classificacao CHAR(3) NOT NULL,
    ds_classificacao NCHAR(100) NOT NULL
);

ALTER TABLE mc_vd_class ADD CONSTRAINT mc_video_classificacao_pk PRIMARY KEY ( cd_classificacao );

CREATE TABLE mc_vd_produto (
    cd_produto                   NUMBER NOT NULL,
    cd_video                     NUMBER(4) NOT NULL,
    cd_classificacao             CHAR(3) NOT NULL,
    data_cadastro                DATE,
    status_video                 CHAR(1) NOT NULL,
    produto_cd_produto           NUMBER NOT NULL,
    mc_vd_class_cd_classificacao CHAR(3) NOT NULL
);

ALTER TABLE mc_vd_produto
    ADD CHECK ( status_video IN ( 'A', 'I' ) );

ALTER TABLE mc_vd_produto ADD CONSTRAINT mc_video_produto_pk PRIMARY KEY ( cd_produto );

CREATE TABLE mc_visual_video (
    cd_visual                NUMBER NOT NULL,
    cd_video                 NUMBER NOT NULL,
    data_hora                DATE,
    id_cliente               NUMBER(5),
    mc_cliente_id_cliente    NUMBER(5) NOT NULL,
    video_produto_cd_video   NUMBER NOT NULL,
    mc_vd_produto_cd_produto NUMBER NOT NULL
);

ALTER TABLE mc_visual_video ADD CONSTRAINT mc_visualizacao_video_pk PRIMARY KEY ( cd_visual );

CREATE TABLE produto (
    cd_produto                     NUMBER NOT NULL,
    descricao_normal               VARCHAR2(255),
    descricao_completa             CLOB,
    codigo_barras                  CHAR(13),
    preco_unitario                 NUMBER(10, 2),
    status                         CHAR(1) NOT NULL,
    categoria_produto_cd_categoria NUMBER NOT NULL
);

ALTER TABLE produto
    ADD CHECK ( status IN ( 'A', 'I', 'P' ) );

ALTER TABLE produto ADD CONSTRAINT produto_pk PRIMARY KEY ( cd_produto );

ALTER TABLE mc_cli_fisica
    ADD CONSTRAINT mc_cli_fisica_mc_cliente_fk FOREIGN KEY ( mc_cliente_id_cliente )
        REFERENCES mc_cliente ( id_cliente );

ALTER TABLE mc_cli_juridica
    ADD CONSTRAINT mc_cli_juridica_mc_cliente_fk FOREIGN KEY ( mc_cliente_id_cliente )
        REFERENCES mc_cliente ( id_cliente );

ALTER TABLE mc_sgv_sac
    ADD CONSTRAINT mc_sgv_sac_mc_funcionario_fk FOREIGN KEY ( mc_funcionario_cd_funcionario )
        REFERENCES mc_funcionario ( cd_funcionario );

ALTER TABLE mc_sgv_sac
    ADD CONSTRAINT mc_sgv_sac_produto_fk FOREIGN KEY ( produto_cd_produto )
        REFERENCES produto ( cd_produto );

ALTER TABLE mc_vd_produto
    ADD CONSTRAINT mc_vd_produto_mc_vd_class_fk FOREIGN KEY ( mc_vd_class_cd_classificacao )
        REFERENCES mc_vd_class ( cd_classificacao );

ALTER TABLE mc_vd_produto
    ADD CONSTRAINT mc_video_produto_produto_fk FOREIGN KEY ( produto_cd_produto )
        REFERENCES produto ( cd_produto );

ALTER TABLE mc_visual_video
    ADD CONSTRAINT mc_visual_video_mc_cliente_fk FOREIGN KEY ( mc_cliente_id_cliente )
        REFERENCES mc_cliente ( id_cliente );

ALTER TABLE mc_visual_video
    ADD CONSTRAINT mc_visual_video_mc_vd_prod_fk FOREIGN KEY ( mc_vd_produto_cd_produto )
        REFERENCES mc_vd_produto ( cd_produto );

ALTER TABLE produto
    ADD CONSTRAINT produto_categoria_produto_fk FOREIGN KEY ( categoria_produto_cd_categoria )
        REFERENCES mc_categoria_produto ( cd_categoria );

ALTER TABLE mc_sgv_sac
    ADD CONSTRAINT sac_mc_cliente_fk FOREIGN KEY ( mc_cliente_id_cliente )
        REFERENCES mc_cliente ( id_cliente );



-- Relatório do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            10
-- CREATE INDEX                             0
-- ALTER TABLE                             22
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
