

CREATE TABLE audio_episodio (
    id bigint NOT NULL,
    audio bytea,
    campo character varying(30),
    episodio bigint
);

CREATE TABLE diagnostico (
    id bigint NOT NULL,
    catalizadores_dolor character varying(4000),
    formula character varying(4000),
    episodio bigint
);


CREATE TABLE episodio (
    id bigint NOT NULL,
    actividades character varying(4000),
    fecha timestamp without time zone,
    medicamentos character varying(4000),
    nivel_dolor character varying(4000),
    patrones_sueno character varying(4000),
    paciente bigint
);


CREATE TABLE paciente (
    id bigint NOT NULL,
    identificacion bigint,
    primer_apellido character varying(250),
    primer_nombre character varying(250),
    segundo_apellido character varying(250),
    segundo_nombre character varying(250)
);


CREATE SEQUENCE seq_audio_episodio
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE seq_diagnostico
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE seq_episodio
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE seq_paciente
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


SELECT pg_catalog.setval('seq_audio_episodio', 1, false);

SELECT pg_catalog.setval('seq_diagnostico', 1, false);

SELECT pg_catalog.setval('seq_episodio', 1, false);

SELECT pg_catalog.setval('seq_paciente', 1, false);


ALTER TABLE ONLY audio_episodio
    ADD CONSTRAINT audio_episodio_pkey PRIMARY KEY (id);


--
-- TOC entry 1905 (class 2606 OID 17897)
-- Name: diagnostico_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY diagnostico
    ADD CONSTRAINT diagnostico_pkey PRIMARY KEY (id);


--
-- TOC entry 1907 (class 2606 OID 17905)
-- Name: episodio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY episodio
    ADD CONSTRAINT episodio_pkey PRIMARY KEY (id);


--
-- TOC entry 1909 (class 2606 OID 17915)
-- Name: paciente_identificacion_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY paciente
    ADD CONSTRAINT paciente_identificacion_key UNIQUE (identificacion);


--
-- TOC entry 1911 (class 2606 OID 17913)
-- Name: paciente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY paciente
    ADD CONSTRAINT paciente_pkey PRIMARY KEY (id);


--
-- TOC entry 1916 (class 2606 OID 17934)
-- Name: fk_audio_episodio_episodio; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY audio_episodio
    ADD CONSTRAINT fk_audio_episodio_episodio FOREIGN KEY (episodio) REFERENCES episodio(id);


--
-- TOC entry 1914 (class 2606 OID 17924)
-- Name: fk_diagnostico_episodio; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY diagnostico
    ADD CONSTRAINT fk_diagnostico_episodio FOREIGN KEY (episodio) REFERENCES episodio(id);


--
-- TOC entry 1915 (class 2606 OID 17929)
-- Name: fk_episodio_paciente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY episodio
    ADD CONSTRAINT fk_episodio_paciente FOREIGN KEY (paciente) REFERENCES paciente(id);
