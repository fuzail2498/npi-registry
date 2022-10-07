--
-- TOC entry 215 (class 1259 OID 99358)
-- Name: address_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.address_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.address_id_seq OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 90958)
-- Name: address; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.address (
    id bigint DEFAULT nextval('public.address_id_seq'::regclass) NOT NULL,
    address_line1 character varying(100),
    address_line2 character varying(100),
    address_discriminator character varying(50),
    city_name character varying(100),
    postal_code character varying(50),
    country_id bigint,
    state_id bigint,
    address_purpose character varying(50),
    telephone_number character varying(50),
    fax_number character varying(50),
    telephone_extention character varying(10),
    address_type character varying(20),
    npi_information_id bigint,
    is_primary boolean
);


ALTER TABLE public.address OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 90964)
-- Name: country; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.country (
    id bigint NOT NULL,
    country_code character varying(2) NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.country OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 90967)
-- Name: entity_type_code; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.entity_type_code (
    id bigint NOT NULL,
    code integer NOT NULL,
    description character varying(100) NOT NULL
);


ALTER TABLE public.entity_type_code OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 90970)
-- Name: gender_codes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gender_codes (
    id integer NOT NULL,
    code character varying(1) NOT NULL,
    description character varying(10) NOT NULL
);


ALTER TABLE public.gender_codes OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 90973)
-- Name: group_taxonomy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_taxonomy (
    id bigint NOT NULL,
    code character varying(20) NOT NULL,
    specialization character varying(50) NOT NULL,
    description character varying(200) NOT NULL
);


ALTER TABLE public.group_taxonomy OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 90976)
-- Name: identifier; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identifier (
    id bigint NOT NULL,
    identifier_id character varying(20) NOT NULL,
    npi_information_id bigint,
    other_provider_identifier_issuer_code_id bigint,
    issuer character varying(80),
    state_id bigint NOT NULL
);


ALTER TABLE public.identifier OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 91083)
-- Name: npi_information_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.npi_information_id_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.npi_information_id_seq OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 90979)
-- Name: npi_information; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.npi_information (
    id bigint DEFAULT nextval('public.npi_information_id_seq'::regclass) NOT NULL,
    number bigint NOT NULL,
    entity_type_code integer,
    last_updated_date date,
    certification_date date,
    deactivation_date date,
    reactivation_date date,
    replacement_npi bigint,
    employer_identification_number character varying(9),
    last_sync_date date NOT NULL,
    organization_name character varying(70),
    last_name character varying(35),
    first_name character varying(20),
    middle_name character varying(20),
    name_prefix_text character varying(5),
    name_suffix_text character varying(5),
    credential_ext character varying(20),
    enumeration_date date,
    gender_code_id integer
);


ALTER TABLE public.npi_information OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 90982)
-- Name: other_provider_identifier_issuer_code; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.other_provider_identifier_issuer_code (
    id bigint NOT NULL,
    code character varying(2) NOT NULL,
    description character varying(100) NOT NULL
);


ALTER TABLE public.other_provider_identifier_issuer_code OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 90985)
-- Name: primary_taxonomy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.primary_taxonomy (
    id bigint NOT NULL,
    switch_code character varying(1) NOT NULL,
    switch_description character varying(20) NOT NULL
);


ALTER TABLE public.primary_taxonomy OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 90988)
-- Name: provider_taxonomy_code; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.provider_taxonomy_code (
    id bigint NOT NULL,
    medicare_speciality_code character varying(10),
    medicare_provider_or_supplier_type_description character varying(100),
    code character varying(10),
    type_classification_specialization character varying(255)
);


ALTER TABLE public.provider_taxonomy_code OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 90991)
-- Name: state; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.state (
    id bigint NOT NULL,
    reference_code character varying(2) NOT NULL,
    name character varying(100) NOT NULL,
    type_code character varying(1) NOT NULL
);


ALTER TABLE public.state OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 132640)
-- Name: taxonomy_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.taxonomy_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.taxonomy_id_seq OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 90994)
-- Name: taxonomy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.taxonomy (
    id bigint DEFAULT nextval('public.taxonomy_id_seq'::regclass) NOT NULL,
    taxanomy_group_id bigint,
    state_id bigint,
    license character varying(50),
    primary_taxonomy_id bigint,
    taxonomy_code_id bigint,
    npi_id bigint
);


ALTER TABLE public.taxonomy OWNER TO postgres;

--
-- TOC entry 2905 (class 0 OID 90958)
-- Dependencies: 202
-- Data for Name: address; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2906 (class 0 OID 90964)
-- Dependencies: 203
-- Data for Name: country; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.country (id, country_code, name) VALUES (1, 'AD', 'ANDORRA');
INSERT INTO public.country (id, country_code, name) VALUES (2, 'AE', 'UNITED ARAB EMIRATES');
INSERT INTO public.country (id, country_code, name) VALUES (3, 'AF', 'AFGHANISTAN');
INSERT INTO public.country (id, country_code, name) VALUES (4, 'AG', 'ANTIGUA AND BARBUDA');
INSERT INTO public.country (id, country_code, name) VALUES (5, 'AI', 'ANGUILLA');
INSERT INTO public.country (id, country_code, name) VALUES (6, 'AL', 'ALBANIA');
INSERT INTO public.country (id, country_code, name) VALUES (7, 'AM', 'ARMENIA');
INSERT INTO public.country (id, country_code, name) VALUES (8, 'AN', 'NETHERLANDS ANTILLES');
INSERT INTO public.country (id, country_code, name) VALUES (9, 'AO', 'ANGOLA');
INSERT INTO public.country (id, country_code, name) VALUES (10, 'AQ', 'ANTARCTICA');
INSERT INTO public.country (id, country_code, name) VALUES (11, 'AR', 'ARGENTINA');
INSERT INTO public.country (id, country_code, name) VALUES (12, 'AT', 'AUSTRIA');
INSERT INTO public.country (id, country_code, name) VALUES (13, 'AU', 'AUSTRALIA');
INSERT INTO public.country (id, country_code, name) VALUES (14, 'AW', 'ARUBA');
INSERT INTO public.country (id, country_code, name) VALUES (15, 'AX', 'ALAND ISLANDS');
INSERT INTO public.country (id, country_code, name) VALUES (16, 'AZ', 'AZERBAIJAN');
INSERT INTO public.country (id, country_code, name) VALUES (17, 'BA', 'BOSNIA AND HERZEGOVINA');
INSERT INTO public.country (id, country_code, name) VALUES (18, 'BB', 'BARBADOS');
INSERT INTO public.country (id, country_code, name) VALUES (19, 'BD', 'BANGLADESH');
INSERT INTO public.country (id, country_code, name) VALUES (20, 'BE', 'BELGIU');
INSERT INTO public.country (id, country_code, name) VALUES (21, 'BF', 'BURKINA FASO');
INSERT INTO public.country (id, country_code, name) VALUES (22, 'BG', 'BULGARIA');
INSERT INTO public.country (id, country_code, name) VALUES (23, 'BH', 'BAHRAIN');
INSERT INTO public.country (id, country_code, name) VALUES (24, 'BI', 'BURUNDI');
INSERT INTO public.country (id, country_code, name) VALUES (25, 'BJ', 'BENIN');
INSERT INTO public.country (id, country_code, name) VALUES (26, 'BM', 'BERMUDA');
INSERT INTO public.country (id, country_code, name) VALUES (27, 'BN', 'BRUNEI DARUSSALAM');
INSERT INTO public.country (id, country_code, name) VALUES (28, 'BO', 'BOLIVIA');
INSERT INTO public.country (id, country_code, name) VALUES (29, 'BR', 'BRAZIL');
INSERT INTO public.country (id, country_code, name) VALUES (30, 'BS', 'BAHAMAS');
INSERT INTO public.country (id, country_code, name) VALUES (31, 'BT', 'BHUTAN');
INSERT INTO public.country (id, country_code, name) VALUES (32, 'BV', 'BOUVET ISLAND');
INSERT INTO public.country (id, country_code, name) VALUES (33, 'BW', 'BOTSWANA');
INSERT INTO public.country (id, country_code, name) VALUES (34, 'BY', 'BELARUS BZ, BELIZE');
INSERT INTO public.country (id, country_code, name) VALUES (35, 'CA', 'CANADA');
INSERT INTO public.country (id, country_code, name) VALUES (36, 'CC', 'COCOS (KEELING) ISLANDS');
INSERT INTO public.country (id, country_code, name) VALUES (37, 'CD', 'CONGO, THE DEMOCRATIC REPUBLIC OF THE');
INSERT INTO public.country (id, country_code, name) VALUES (38, 'CF', 'CENTRAL AFRICAN REPUBLIC');
INSERT INTO public.country (id, country_code, name) VALUES (39, 'CG', 'CONGO');
INSERT INTO public.country (id, country_code, name) VALUES (40, 'CH', 'SWITZERLAND');
INSERT INTO public.country (id, country_code, name) VALUES (41, 'CI', 'CÔTE D''IVOIRE');
INSERT INTO public.country (id, country_code, name) VALUES (42, 'CK', 'COOK ISLANDS');
INSERT INTO public.country (id, country_code, name) VALUES (43, 'CL', 'CHILE');
INSERT INTO public.country (id, country_code, name) VALUES (44, 'CM', 'CAMEROON');
INSERT INTO public.country (id, country_code, name) VALUES (45, 'CN', 'CHINA');
INSERT INTO public.country (id, country_code, name) VALUES (46, 'CO', 'COLOMBIA');
INSERT INTO public.country (id, country_code, name) VALUES (47, 'CR', 'COSTA RICA');
INSERT INTO public.country (id, country_code, name) VALUES (48, 'CS', 'SERBIA AND MONTENEGRO');
INSERT INTO public.country (id, country_code, name) VALUES (49, 'CU', 'CUBA');
INSERT INTO public.country (id, country_code, name) VALUES (50, 'CV', 'CAPE VERDE');
INSERT INTO public.country (id, country_code, name) VALUES (51, 'CX', 'CHRISTMAS ISLAND');
INSERT INTO public.country (id, country_code, name) VALUES (52, 'CY', 'CYPRUS');
INSERT INTO public.country (id, country_code, name) VALUES (53, 'CZ', 'CZECH REPUBLIC');
INSERT INTO public.country (id, country_code, name) VALUES (54, 'DE', 'GERMANY');
INSERT INTO public.country (id, country_code, name) VALUES (55, 'DJ', 'DJIBOUTI');
INSERT INTO public.country (id, country_code, name) VALUES (56, 'DK', 'DENMARK');
INSERT INTO public.country (id, country_code, name) VALUES (57, 'DM', 'DOMINICA');
INSERT INTO public.country (id, country_code, name) VALUES (58, 'DO', 'DOMINICAN REPUBLIC');
INSERT INTO public.country (id, country_code, name) VALUES (59, 'DZ', 'ALGERIA');
INSERT INTO public.country (id, country_code, name) VALUES (60, 'EC', 'ECUADOR');
INSERT INTO public.country (id, country_code, name) VALUES (61, 'EE', 'ESTONIA');
INSERT INTO public.country (id, country_code, name) VALUES (62, 'EG', 'EGYPT');
INSERT INTO public.country (id, country_code, name) VALUES (63, 'EH', 'WESTERN SAHARA');
INSERT INTO public.country (id, country_code, name) VALUES (64, 'ER', 'ERITREA');
INSERT INTO public.country (id, country_code, name) VALUES (65, 'ES', 'SPAIN');
INSERT INTO public.country (id, country_code, name) VALUES (66, 'ET', 'ETHIOPIA');
INSERT INTO public.country (id, country_code, name) VALUES (67, 'FI', 'FINLAND');
INSERT INTO public.country (id, country_code, name) VALUES (68, 'FJ', 'FIJI');
INSERT INTO public.country (id, country_code, name) VALUES (69, 'FK', 'FALKLAND ISLANDS (MALVINAS)');
INSERT INTO public.country (id, country_code, name) VALUES (70, 'FO', 'FAROE ISLANDS');
INSERT INTO public.country (id, country_code, name) VALUES (71, 'FR', 'FRANCE');
INSERT INTO public.country (id, country_code, name) VALUES (72, 'GA', 'GABON');
INSERT INTO public.country (id, country_code, name) VALUES (73, 'GB', 'GREAT BRITAIN (UK)');
INSERT INTO public.country (id, country_code, name) VALUES (74, 'GD', 'GRENADA');
INSERT INTO public.country (id, country_code, name) VALUES (75, 'GE', 'GEORGIA');
INSERT INTO public.country (id, country_code, name) VALUES (76, 'GF', 'FRENCH GUIANA');
INSERT INTO public.country (id, country_code, name) VALUES (77, 'GG', 'GUERNSEY');
INSERT INTO public.country (id, country_code, name) VALUES (78, 'GH', 'GHANA');
INSERT INTO public.country (id, country_code, name) VALUES (79, 'GI', 'GIBRALTAR');
INSERT INTO public.country (id, country_code, name) VALUES (80, 'GL', 'GREENLAND');
INSERT INTO public.country (id, country_code, name) VALUES (81, 'GM', 'GAMBIA');
INSERT INTO public.country (id, country_code, name) VALUES (82, 'GN', 'GUINEA');
INSERT INTO public.country (id, country_code, name) VALUES (83, 'GP', 'GUADELOUPE');
INSERT INTO public.country (id, country_code, name) VALUES (84, 'GQ', 'EQUATORIAL GUINEA');
INSERT INTO public.country (id, country_code, name) VALUES (85, 'GR', 'GREECE');
INSERT INTO public.country (id, country_code, name) VALUES (86, 'GS', 'SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS');
INSERT INTO public.country (id, country_code, name) VALUES (87, 'GT', 'GUATEMALA');
INSERT INTO public.country (id, country_code, name) VALUES (88, 'GW', 'GUINEA-BISSAU');
INSERT INTO public.country (id, country_code, name) VALUES (89, 'GY', 'GUYANA');
INSERT INTO public.country (id, country_code, name) VALUES (90, 'HK', 'HONG KONG');
INSERT INTO public.country (id, country_code, name) VALUES (91, 'HM', 'HEARD ISLAND AND MCDONALD ISLANDS');
INSERT INTO public.country (id, country_code, name) VALUES (92, 'HN', 'HONDURAS');
INSERT INTO public.country (id, country_code, name) VALUES (93, 'HR', 'CROATIA');
INSERT INTO public.country (id, country_code, name) VALUES (94, 'HT', 'HAITI');
INSERT INTO public.country (id, country_code, name) VALUES (95, 'HU', 'HUNGARY');
INSERT INTO public.country (id, country_code, name) VALUES (96, 'ID', 'INDONESIA');
INSERT INTO public.country (id, country_code, name) VALUES (97, 'IE', 'IRELAND');
INSERT INTO public.country (id, country_code, name) VALUES (98, 'IL', 'ISRAEL');
INSERT INTO public.country (id, country_code, name) VALUES (99, 'IM', 'ISLE OF MAN');
INSERT INTO public.country (id, country_code, name) VALUES (100, 'IN', 'INDIA');
INSERT INTO public.country (id, country_code, name) VALUES (101, 'IO', 'BRITISH INDIAN OCEAN TERRITORY');
INSERT INTO public.country (id, country_code, name) VALUES (102, 'IQ', 'IRAQ');
INSERT INTO public.country (id, country_code, name) VALUES (103, 'IR', 'IRAN, ISLAMIC REPUBLIC OF');
INSERT INTO public.country (id, country_code, name) VALUES (104, 'IS', 'ICELAND');
INSERT INTO public.country (id, country_code, name) VALUES (105, 'IT', 'ITALY');
INSERT INTO public.country (id, country_code, name) VALUES (106, 'JE', 'JERSEY');
INSERT INTO public.country (id, country_code, name) VALUES (107, 'JM', 'JAMAICA');
INSERT INTO public.country (id, country_code, name) VALUES (108, 'JO', 'JORDAN');
INSERT INTO public.country (id, country_code, name) VALUES (109, 'JP', 'JAPAN');
INSERT INTO public.country (id, country_code, name) VALUES (110, 'KE', 'KENYA');
INSERT INTO public.country (id, country_code, name) VALUES (111, 'KG', 'KYRGYZSTAN');
INSERT INTO public.country (id, country_code, name) VALUES (112, 'KH', 'CAMBODIA');
INSERT INTO public.country (id, country_code, name) VALUES (113, 'KI', 'KIRIBATI');
INSERT INTO public.country (id, country_code, name) VALUES (114, 'KM', 'COMOROS');
INSERT INTO public.country (id, country_code, name) VALUES (115, 'KN', 'SAINT KITTS AND NEVIS');
INSERT INTO public.country (id, country_code, name) VALUES (116, 'KP', 'KOREA, DEMOCRATIC PEOPLE''S REPUBLIC OF');
INSERT INTO public.country (id, country_code, name) VALUES (117, 'KR', 'KOREA, REPUBLIC OF');
INSERT INTO public.country (id, country_code, name) VALUES (118, 'KW', 'KUWAIT');
INSERT INTO public.country (id, country_code, name) VALUES (119, 'KY', 'CAYMAN ISLANDS');
INSERT INTO public.country (id, country_code, name) VALUES (120, 'KZ', 'KAZAKHSTAN');
INSERT INTO public.country (id, country_code, name) VALUES (121, 'LA', 'LAO PEOPLE''S DEMOCRATIC REPUBLIC');
INSERT INTO public.country (id, country_code, name) VALUES (122, 'LB', 'LEBANON');
INSERT INTO public.country (id, country_code, name) VALUES (123, 'LC', 'SAINT LUCIA');
INSERT INTO public.country (id, country_code, name) VALUES (124, 'LI', 'LIECHTENSTEIN');
INSERT INTO public.country (id, country_code, name) VALUES (125, 'LK', 'SRI LANKA');
INSERT INTO public.country (id, country_code, name) VALUES (126, 'LR', 'LIBERIA');
INSERT INTO public.country (id, country_code, name) VALUES (127, 'LS', 'LESOTHO');
INSERT INTO public.country (id, country_code, name) VALUES (128, 'LT', 'LITHUANIA');
INSERT INTO public.country (id, country_code, name) VALUES (129, 'LU', 'LUXEMBOURG');
INSERT INTO public.country (id, country_code, name) VALUES (130, 'LV', 'LATVIA');
INSERT INTO public.country (id, country_code, name) VALUES (131, 'LY', 'LIBYAN ARAB JAMAHIRIYA');
INSERT INTO public.country (id, country_code, name) VALUES (132, 'MA', 'MOROCCO');
INSERT INTO public.country (id, country_code, name) VALUES (133, 'MC', 'MONACO');
INSERT INTO public.country (id, country_code, name) VALUES (134, 'MD', 'MOLDOVA, REPUBLIC OF');
INSERT INTO public.country (id, country_code, name) VALUES (135, 'MG', 'MADAGASCAR');
INSERT INTO public.country (id, country_code, name) VALUES (136, 'MK', 'MACEDONIA, THE FORMER YUGOSLAV REPUBLIC OF');
INSERT INTO public.country (id, country_code, name) VALUES (137, 'ML', 'MALI');
INSERT INTO public.country (id, country_code, name) VALUES (138, 'MM', 'MYANMAR');
INSERT INTO public.country (id, country_code, name) VALUES (139, 'MN', 'MONGOLIA');
INSERT INTO public.country (id, country_code, name) VALUES (140, 'MO', 'MACAO');
INSERT INTO public.country (id, country_code, name) VALUES (141, 'MQ', 'MARTINIQUE');
INSERT INTO public.country (id, country_code, name) VALUES (142, 'MR', 'MAURITANIA');
INSERT INTO public.country (id, country_code, name) VALUES (143, 'MS', 'MONTSERRAT');
INSERT INTO public.country (id, country_code, name) VALUES (144, 'MT', 'MALTA');
INSERT INTO public.country (id, country_code, name) VALUES (145, 'MU', 'MAURITIUS');
INSERT INTO public.country (id, country_code, name) VALUES (146, 'MV', 'MALDIVES');
INSERT INTO public.country (id, country_code, name) VALUES (147, 'MW', 'MALAWI');
INSERT INTO public.country (id, country_code, name) VALUES (148, 'MX', 'MEXICO');
INSERT INTO public.country (id, country_code, name) VALUES (149, 'MY', 'MALAYSIA');
INSERT INTO public.country (id, country_code, name) VALUES (150, 'MZ', 'MOZAMBIQUE');
INSERT INTO public.country (id, country_code, name) VALUES (151, 'NA', 'NAMIBIA');
INSERT INTO public.country (id, country_code, name) VALUES (152, 'NC', 'NEW CALEDONIA');
INSERT INTO public.country (id, country_code, name) VALUES (153, 'NE', 'NIGER');
INSERT INTO public.country (id, country_code, name) VALUES (154, 'NF', 'NORFOLK ISLAND');
INSERT INTO public.country (id, country_code, name) VALUES (155, 'NG', 'NIGERIA');
INSERT INTO public.country (id, country_code, name) VALUES (156, 'NI', 'NICARAGUA');
INSERT INTO public.country (id, country_code, name) VALUES (157, 'NL', 'NETHERLANDS');
INSERT INTO public.country (id, country_code, name) VALUES (158, 'NO', 'NORWAY');
INSERT INTO public.country (id, country_code, name) VALUES (159, 'NP', 'NEPAL');
INSERT INTO public.country (id, country_code, name) VALUES (160, 'NR', 'NAURU');
INSERT INTO public.country (id, country_code, name) VALUES (161, 'NU', 'NIUE');
INSERT INTO public.country (id, country_code, name) VALUES (162, 'NZ', 'NEW ZEALAND');
INSERT INTO public.country (id, country_code, name) VALUES (163, 'OM', 'OMAN');
INSERT INTO public.country (id, country_code, name) VALUES (164, 'PA', 'PANAMA');
INSERT INTO public.country (id, country_code, name) VALUES (165, 'PE', 'PERU');
INSERT INTO public.country (id, country_code, name) VALUES (166, 'PF', 'FRENCH POLYNESIA');
INSERT INTO public.country (id, country_code, name) VALUES (167, 'PG', 'PAPUA NEW GUINEA');
INSERT INTO public.country (id, country_code, name) VALUES (168, 'PH', 'PHILIPPINES');
INSERT INTO public.country (id, country_code, name) VALUES (169, 'PK', 'PAKISTAN');
INSERT INTO public.country (id, country_code, name) VALUES (170, 'PL', 'POLAND');
INSERT INTO public.country (id, country_code, name) VALUES (171, 'PM', 'SAINT PIERRE AND MIQUELON');
INSERT INTO public.country (id, country_code, name) VALUES (172, 'PN', 'PITCAIRN');
INSERT INTO public.country (id, country_code, name) VALUES (173, 'PS', 'PALESTINIAN TERRITORY, OCCUPIED');
INSERT INTO public.country (id, country_code, name) VALUES (174, 'PT', 'PORTUGAL');
INSERT INTO public.country (id, country_code, name) VALUES (175, 'PY', 'PARAGUAY');
INSERT INTO public.country (id, country_code, name) VALUES (176, 'QA', 'QATAR');
INSERT INTO public.country (id, country_code, name) VALUES (177, 'RE', 'REUNION');
INSERT INTO public.country (id, country_code, name) VALUES (178, 'RO', 'ROMANIA');
INSERT INTO public.country (id, country_code, name) VALUES (179, 'RU', 'RUSSIAN FEDERATION');
INSERT INTO public.country (id, country_code, name) VALUES (180, 'RW', 'RWANDA');
INSERT INTO public.country (id, country_code, name) VALUES (181, 'SA', 'SAUDI ARABIA');
INSERT INTO public.country (id, country_code, name) VALUES (182, 'SB', 'SOLOMON ISLANDS');
INSERT INTO public.country (id, country_code, name) VALUES (183, 'SC', 'SEYCHELLES');
INSERT INTO public.country (id, country_code, name) VALUES (184, 'SD', 'SUDAN');
INSERT INTO public.country (id, country_code, name) VALUES (185, 'SE', 'SWEDEN');
INSERT INTO public.country (id, country_code, name) VALUES (186, 'SG', 'SINGAPORE');
INSERT INTO public.country (id, country_code, name) VALUES (187, 'SH', 'SAINT HELENA');
INSERT INTO public.country (id, country_code, name) VALUES (188, 'SI', 'SLOVENIA');
INSERT INTO public.country (id, country_code, name) VALUES (189, 'SJ', 'SVALBARD AND JAN MAYEN');
INSERT INTO public.country (id, country_code, name) VALUES (190, 'SK', 'SLOVAKIA');
INSERT INTO public.country (id, country_code, name) VALUES (191, 'SL', 'SIERRA LEONE');
INSERT INTO public.country (id, country_code, name) VALUES (192, 'SM', 'SAN MARINO');
INSERT INTO public.country (id, country_code, name) VALUES (193, 'SN', 'SENEGAL');
INSERT INTO public.country (id, country_code, name) VALUES (194, 'SO', 'SOMALIA');
INSERT INTO public.country (id, country_code, name) VALUES (195, 'SR', 'SURINAME');
INSERT INTO public.country (id, country_code, name) VALUES (196, 'ST', 'SAO TOME AND PRINCIPE');
INSERT INTO public.country (id, country_code, name) VALUES (197, 'SV', 'EL SALVADOR');
INSERT INTO public.country (id, country_code, name) VALUES (198, 'SY', 'SYRIAN ARAB REPUBLIC');
INSERT INTO public.country (id, country_code, name) VALUES (199, 'SZ', 'SWAZILAND');
INSERT INTO public.country (id, country_code, name) VALUES (200, 'TC', 'TURKS AND CAICOS ISLANDS');
INSERT INTO public.country (id, country_code, name) VALUES (201, 'TD', 'CHAD');
INSERT INTO public.country (id, country_code, name) VALUES (202, 'TF', 'FRENCH SOUTHERN TERRITORIES');
INSERT INTO public.country (id, country_code, name) VALUES (203, 'TG', 'TOGO');
INSERT INTO public.country (id, country_code, name) VALUES (204, 'TH', 'THAILAND');
INSERT INTO public.country (id, country_code, name) VALUES (205, 'TJ', 'TAJIKISTAN');
INSERT INTO public.country (id, country_code, name) VALUES (206, 'TK', 'TOKELAU');
INSERT INTO public.country (id, country_code, name) VALUES (207, 'TL', 'TIMOR-LESTE');
INSERT INTO public.country (id, country_code, name) VALUES (208, 'TM', 'TURKMENISTAN');
INSERT INTO public.country (id, country_code, name) VALUES (209, 'TN', 'TUNISIA');
INSERT INTO public.country (id, country_code, name) VALUES (210, 'TO', 'TONGA');
INSERT INTO public.country (id, country_code, name) VALUES (211, 'TR', 'TURKEY');
INSERT INTO public.country (id, country_code, name) VALUES (212, 'TT', 'TRINIDAD AND TOBAGO');
INSERT INTO public.country (id, country_code, name) VALUES (213, 'TV', 'TUVALU');
INSERT INTO public.country (id, country_code, name) VALUES (214, 'TW', 'TAIWAN ');
INSERT INTO public.country (id, country_code, name) VALUES (215, 'TZ', 'TANZANIA, UNITED REPUBLIC OF');
INSERT INTO public.country (id, country_code, name) VALUES (216, 'UA', 'UKRAINE');
INSERT INTO public.country (id, country_code, name) VALUES (217, 'UG', 'UGANDA');
INSERT INTO public.country (id, country_code, name) VALUES (218, 'UM', 'UNITED STATES MINOR OUTLYING ISLANDS');
INSERT INTO public.country (id, country_code, name) VALUES (219, 'US', 'UNITED STATES');
INSERT INTO public.country (id, country_code, name) VALUES (220, 'UY', 'URUGUAY');
INSERT INTO public.country (id, country_code, name) VALUES (221, 'UZ', 'UZBEKISTAN');
INSERT INTO public.country (id, country_code, name) VALUES (222, 'VA', 'HOLY SEE (VATICAN CITY STATE)');
INSERT INTO public.country (id, country_code, name) VALUES (223, 'VC', 'SAINT VINCENT AND THE GRENADINES');
INSERT INTO public.country (id, country_code, name) VALUES (224, 'VE', 'VENEZUELA');
INSERT INTO public.country (id, country_code, name) VALUES (225, 'VG', 'VIRGIN ISLANDS, BRITISH');
INSERT INTO public.country (id, country_code, name) VALUES (226, 'VN', 'VIET NAM');
INSERT INTO public.country (id, country_code, name) VALUES (227, 'VU', 'VANUATU');
INSERT INTO public.country (id, country_code, name) VALUES (228, 'WF', 'WALLIS AND FUTUNA');
INSERT INTO public.country (id, country_code, name) VALUES (229, 'WS', 'SAMOA');
INSERT INTO public.country (id, country_code, name) VALUES (230, 'XK', 'KOSOVO');
INSERT INTO public.country (id, country_code, name) VALUES (231, 'YE', 'YEMEN');
INSERT INTO public.country (id, country_code, name) VALUES (232, 'YT', 'MAYOTTE');
INSERT INTO public.country (id, country_code, name) VALUES (233, 'ZA', 'SOUTH AFRICA');
INSERT INTO public.country (id, country_code, name) VALUES (234, 'ZM', 'ZAMBIA');
INSERT INTO public.country (id, country_code, name) VALUES (235, 'ZW', 'ZIMBABWE');


--
-- TOC entry 2907 (class 0 OID 90967)
-- Dependencies: 204
-- Data for Name: entity_type_code; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.entity_type_code (id, code, description) VALUES (1, 1, 'Individual');
INSERT INTO public.entity_type_code (id, code, description) VALUES (2, 2, 'Organization');


--
-- TOC entry 2908 (class 0 OID 90970)
-- Dependencies: 205
-- Data for Name: gender_codes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.gender_codes (id, code, description) VALUES (1, 'M', 'Male');
INSERT INTO public.gender_codes (id, code, description) VALUES (2, 'F', 'Female');


--
-- TOC entry 2909 (class 0 OID 90973)
-- Dependencies: 206
-- Data for Name: group_taxonomy; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.group_taxonomy (id, code, specialization, description) VALUES (1, '193200000X', 'Multi-Specialty', 'A business group of one or more individual practitioners, who practice with different areas of specialization.');
INSERT INTO public.group_taxonomy (id, code, specialization, description) VALUES (2, '193400000X', 'Single Specialty', 'A business group of one or more individual practitioners, all of who practice with the same area of specialization.');


--
-- TOC entry 2910 (class 0 OID 90976)
-- Dependencies: 207
-- Data for Name: identifier; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2911 (class 0 OID 90979)
-- Dependencies: 208
-- Data for Name: npi_information; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2912 (class 0 OID 90982)
-- Dependencies: 209
-- Data for Name: other_provider_identifier_issuer_code; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.other_provider_identifier_issuer_code (id, code, description) VALUES (1, '01', 'OTHER');
INSERT INTO public.other_provider_identifier_issuer_code (id, code, description) VALUES (2, '02', 'MEDICARE UPIN');
INSERT INTO public.other_provider_identifier_issuer_code (id, code, description) VALUES (3, '04', 'MEDICARE ID-TYPE UNSPECIFIED');
INSERT INTO public.other_provider_identifier_issuer_code (id, code, description) VALUES (4, '05', 'MEDICAID');
INSERT INTO public.other_provider_identifier_issuer_code (id, code, description) VALUES (5, '06', 'MEDICARE OSCAR/CERTIFICATION');
INSERT INTO public.other_provider_identifier_issuer_code (id, code, description) VALUES (6, '07', 'MEDICARE NSC');
INSERT INTO public.other_provider_identifier_issuer_code (id, code, description) VALUES (7, '08', 'MEDICARE PIN');


--
-- TOC entry 2913 (class 0 OID 90985)
-- Dependencies: 210
-- Data for Name: primary_taxonomy; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.primary_taxonomy (id, switch_code, switch_description) VALUES (1, 'X', 'Not Answered');
INSERT INTO public.primary_taxonomy (id, switch_code, switch_description) VALUES (2, 'Y', 'Yes');
INSERT INTO public.primary_taxonomy (id, switch_code, switch_description) VALUES (3, 'N', 'No');


--
-- TOC entry 2914 (class 0 OID 90988)
-- Dependencies: 211
-- Data for Name: provider_taxonomy_code; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (1, '1', 'Physician/General Practice', '208D00000X', 'Allopathic & Osteopathic Physicians/General Practice');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (2, '2', 'Physician/General Surgery', '208600000X', 'Allopathic & Osteopathic Physicians/Surgery');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (3, '2', 'Physician/General Surgery', '2086H0002X', 'Allopathic & Osteopathic Physicians/Surgery/Hospice and Palliative Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (4, '2', 'Physician/General Surgery', '2086S0120X', 'Allopathic & Osteopathic Physicians/Surgery/Pediatric Surgery');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (5, '2', 'Physician/General Surgery', '2086S0122X', 'Allopathic & Osteopathic Physicians/Surgery/Plastic and Reconstructive Surgery');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (6, '2', 'Physician/General Surgery', '2086S0105X', 'Allopathic & Osteopathic Physicians/Surgery/Surgery of the Hand');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (7, '2', 'Physician/General Surgery', '2086S0102X', 'Allopathic & Osteopathic Physicians/Surgery/Surgical Critical Care');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (8, '2', 'Physician/General Surgery', '2086X0206X', 'Allopathic & Osteopathic Physicians/Surgery/Surgical Oncology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (9, '2', 'Physician/General Surgery', '2086S0127X', 'Allopathic & Osteopathic Physicians/Surgery/Trauma Surgery');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (10, '2', 'Physician/General Surgery', '2086S0129X', 'Allopathic & Osteopathic Physicians/Surgery/Vascular Surgery');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (11, '2', 'Physician/General Surgery', '208G00000X', 'Allopathic & Osteopathic Physicians/Thoracic Surgery (Cardiothoracic Vascular Surgery)');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (12, '2', 'Physician/General Surgery', '204F00000X', 'Allopathic & Osteopathic Physicians/Transplant Surgery');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (13, '2', 'Physician/General Surgery', '208C00000X', 'Allopathic & Osteopathic Physicians/Colon & Rectal Surgery');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (14, '2', 'Physician/General Surgery', '207T00000X', 'Allopathic & Osteopathic Physicians/Neurological Surgery');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (15, '2', 'Physician/General Surgery', '204E00000X', 'Allopathic & Osteopathic Physicians/Oral & Maxillofacial Surgery');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (16, '2', 'Physician/General Surgery', '207X00000X', 'Allopathic & Osteopathic Physicians/Orthopedic Surgery');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (17, '2', 'Physician/General Surgery', '207XS0114X', 'Allopathic & Osteopathic Physicians/Orthopedic Surgery/Adult Reconstructive Orthopedic Surgery');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (18, '2', 'Physician/General Surgery', '207XX0004X', 'Allopathic & Osteopathic Physicians/Orthopedic Surgery/Foot and Ankle Surgery');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (19, '2', 'Physician/General Surgery', '207XS0106X', 'Allopathic & Osteopathic Physicians/Orthopedic Surgery/Hand Surgery');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (20, '2', 'Physician/General Surgery', '207XS0117X', 'Allopathic & Osteopathic Physicians/Orthopedic Surgery/Orthopedic Surgery of the Spine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (21, '2', 'Physician/General Surgery', '207XX0801X', 'Allopathic & Osteopathic Physicians/Orthopedic Surgery/Orthopedic Trauma');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (22, '2', 'Physician/General Surgery', '207XP3100X', 'Allopathic & Osteopathic Physicians/Orthopedic Surgery/Pediatric Orthopedic Surgery');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (23, '2', 'Physician/General Surgery', '207XX0005X', 'Allopathic & Osteopathic Physicians/Orthopedic Surgery/Sports Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (24, '2', 'Physician/General Surgery', '208200000X', 'Allopathic & Osteopathic Physicians/Plastic Surgery');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (25, '2', 'Physician/General Surgery', '2082S0099X', 'Allopathic & Osteopathic Physicians/Plastic Surgery/Plastic Surgery Within the Head & Neck');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (26, '2', 'Physician/General Surgery', '2082S0105X', 'Allopathic & Osteopathic Physicians/Plastic Surgery/Surgery of the Hand');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (27, '3', 'Physician/Allergy/ Immunology', '207K00000X', 'Allopathic & Osteopathic Physicians/Allergy and Immunology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (28, '3', 'Physician/Allergy/ Immunology', '207KA0200X', 'Allopathic & Osteopathic Physicians/Allergy and Immunology/Allergy');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (29, '3', 'Physician/Allergy/ Immunology', '207KI0005X', 'Allopathic & Osteopathic Physicians/Allergy and Immunology/Clinical & Laboratory Immunology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (30, '4', 'Physician/Otolaryngology', '207Y00000X', 'Allopathic & Osteopathic Physicians/ Otolaryngology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (31, '4', 'Physician/Otolaryngology', '207YS0123X', 'Allopathic & Osteopathic Physicians/ Otolaryngology/Facial Plastic Surgery');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (32, '4', 'Physician/Otolaryngology', '207YX0602X', 'Allopathic & Osteopathic Physicians/Otolaryngology/Otolaryngic Allergy');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (33, '4', 'Physician/Otolaryngology', '207YX0905X', 'Allopathic & Osteopathic Physicians/Otolaryngology/Otolaryngology/Facial Plastic Surgery');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (34, '4', 'Physician/Otolaryngology', '207YX0901X', 'Allopathic & Osteopathic Physicians/Otolaryngology/Otology &Neurotology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (35, '4', 'Physician/Otolaryngology', '207YP0228X', 'Allopathic & Osteopathic Physicians/Otolaryngology/Pediatric Otolaryngology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (36, '4', 'Physician/Otolaryngology', '207YX0007X', 'Allopathic & Osteopathic Physicians/Otolaryngology/Plastic Surgery within the Head & Neck');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (37, '4', 'Physician/Otolaryngology', '207YS0012X', 'Allopathic & Osteopathic Physicians/Otolaryngology/Sleep Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (38, '5', 'Physician/Anesthesiology', '207L00000X', 'Allopathic & Osteopathic Physicians/Anesthesiology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (39, '5', 'Physician/Anesthesiology', '207LA0401X', 'Allopathic & Osteopathic Physicians/Anesthesiology/Addiction Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (40, '5', 'Physician/Anesthesiology', '207LC0200X', 'Allopathic & Osteopathic Physicians/Anesthesiology/Critical Care Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (41, '5', 'Physician/Anesthesiology', '207LH0002X', 'Allopathic & Osteopathic Physicians/Anesthesiology/Hospice and Palliative Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (42, '5', 'Physician/Anesthesiology', '207LP2900X', 'Allopathic & Osteopathic Physicians/Anesthesiology/Pain Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (43, '5', 'Physician/Anesthesiology', '207LP3000X', 'Allopathic & Osteopathic Physicians/Anesthesiology/Pediatric Anesthesiology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (44, '6', 'Physician/Cardiovascular Disease (Cardiology)', '207RC0000X', 'Allopathic & Osteopathic Physicians/Internal Medicine Cardiovascular Disease');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (45, '7', 'Physician/Dermatology', '207N00000X', 'Allopathic & Osteopathic Physicians/Dermatology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (46, '7', 'Physician/Dermatology', '207NI0002X', 'Allopathic & Osteopathic Physicians/Dermatology Clinical & Laboratory Dermatological Immunology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (47, '7', 'Physician/Dermatology', '207ND0101X', 'Allopathic & Osteopathic Physicians/Dermatology MOHS-Micrographic Surgery');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (48, '7', 'Physician/Dermatology', '207ND0900X', 'Allopathic & Osteopathic Physicians/Dermatology Dermapathology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (49, '7', 'Physician/Dermatology', '207NP0225X', 'Allopathic & Osteopathic Physicians/Dermatology Pediatric Dermatology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (50, '7', 'Physician/Dermatology', '207NS0135X', 'Allopathic &Osteopathic Physicians/Dermatology Procedural Dermatology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (51, '8', 'Physician/Family Practice', '207Q00000X', 'Allopathic & Osteopathic Physicians/Family Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (52, '8', 'Physician/Family Practice', '207QA0401X', 'Allopathic & Osteopathic Physicians/Family Medicine Addiction Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (53, '8', 'Physician/Family Practice', '207QA0000X', 'Allopathic & Osteopathic Physicians/Family Medicine Adolescent Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (54, '8', 'Physician/Family Practice', '207QA0505X', 'Allopathic & Osteopathic Physicians/Family Medicine Adult Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (55, '8', 'Physician/Family Practice', '207QB0002X', 'Allopathic & Osteopathic Physicians/Family Medicine Bariatric Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (56, '8', 'Physician/Family Practice', '207QG0300X', 'Allopathic & Osteopathic Physicians/Family Medicine Geriatric Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (57, '8', 'Physician/Family Practice', '207QH0002X', 'Allopathic & Osteopathic Physicians/Family Medicine Hospice and Palliative Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (58, '8', 'Physician/Family Practice', '207QS0010X', 'Allopathic & Osteopathic Physicians/Family Medicine Sports Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (59, '8', 'Physician/Family Practice', '207QS1201X', 'Allopathic & Osteopathic Physicians/Family Medicine Sleep Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (60, '9', 'Physician/Interventional Pain Management', '208VP0014X', 'Allopathic & Osteopathic Physicians/Pain Medicine Interventional Pain Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (61, '10', 'Physician/Gastroenterology', '207RG0100X', 'Allopathic & Osteopathic Physicians/Internal Medicine Gastroenterology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (62, '11', 'Physician/Internal Medicine', '207R00000X', 'Allopathic & Osteopathic Physicians/Internal Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (63, '11', 'Physician/Internal Medicine', '207RA0401X', 'Allopathic & Osteopathic Physicians/Internal Medicine Addiction Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (64, '11', 'Physician/Internal Medicine', '207RA0000X', 'Allopathic & Osteopathic Physicians/Internal Medicine Adolescent Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (65, '11', 'Physician/Internal Medicine', '207RA0001X', 'Allopathic & Osteopathic Physicians/Advanced Heart Failure and Transplant Cardiology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (66, '11', 'Physician/Internal Medicine', '207RA0201X', 'Allopathic & Osteopathic Physicians/Internal Medicine Allergy & Immunology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (67, '11', 'Physician/Internal Medicine', '207RB0002X', 'Allopathic & Osteopathic Physicians/Internal Medicine Bariatric Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (68, '11', 'Physician/Internal Medicine', '207RC0000X', 'Allopathic & Osteopathic Physicians/Internal Medicine Cardiovascular Disease');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (69, '11', 'Physician/Internal Medicine', '207RI0001X', 'Allopathic & Osteopathic Physicians/Internal Medicine Clinical & Laboratory Immunology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (70, '11', 'Physician/Internal Medicine', '207RC0200X', 'Allopathic & Osteopathic Physicians/Internal Medicine Critical Care Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (71, '11', 'Physician/Internal Medicine', '207RE0101X', 'Allopathic & Osteopathic Physicians/Internal Medicine Endocrinology Diabetes & Metabolism');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (72, '11', 'Physician/Internal Medicine', '207RG0100X', 'Allopathic & Osteopathic Physicians/Internal Medicine Gastroenterology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (73, '11', 'Physician/Internal Medicine', '207RG0300X', 'Allopathic & Osteopathic Physicians/Internal Medicine Geriatric Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (74, '11', 'Physician/Internal Medicine', '207RH0000X', 'Allopathic & Osteopathic Physicians/Internal Medicine Hematology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (75, '11', 'Physician/Internal Medicine', '207RH0003X', 'Allopathic & Osteopathic Physicians/Internal Medicine Hematology & Oncology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (76, '11', 'Physician/Internal Medicine', '207RI0008X', 'Allopathic & Osteopathic Physicians/Internal Medicine Hepatology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (77, '11', 'Physician/Internal Medicine', '207RH0002X', 'Allopathic & Osteopathic Physicians/Internal Medicine Hospice and Palliative Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (78, '11', 'Physician/Internal Medicine', '207RI0200X', 'Allopathic & Osteopathic Physicians/Internal Medicine Infectious Disease');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (79, '11', 'Physician/Internal Medicine', '207RM1200X', 'Allopathic & Osteopathic Physicians/Internal Medicine Magnetic Resonance Imaging (MRI)');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (80, '11', 'Physician/Internal Medicine', '207RX0202X', 'Allopathic & Osteopathic Physicians/Internal Medicine Medical Oncology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (81, '11', 'Physician/Internal Medicine', '207RN0300X', 'Allopathic & Osteopathic Physicians/Internal Medicine Nephrology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (82, '11', 'Physician/Internal Medicine', '207RP1001X', 'Allopathic & Osteopathic Physicians/Internal Medicine Pulmonary Disease');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (83, '11', 'Physician/Internal Medicine', '207RR0500X', 'Allopathic & Osteopathic Physicians/Internal Medicine Rheumatology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (84, '11', 'Physician/Internal Medicine', '207RS0012X', 'Allopathic & Osteopathic Physicians/Internal Medicine Sleep Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (85, '11', 'Physician/Internal Medicine', '207RS0010X', 'Allopathic & Osteopathic Physicians/Internal Medicine Sports Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (86, '11', 'Physician/Internal Medicine', '207RT0003X', 'Allopathic & Osteopathic Physicians/Internal Medicine Transplant Hepatology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (87, '12', 'Physician/Osteopathic Manipulative Medicine', '204D00000X', 'Allopathic & Osteopathic Physicians/Neuromusculoskeletal Medicine & OMM');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (88, '12', 'Physician/Osteopathic Manipulative Medicine', '204C00000X', 'Allopathic & Osteopathic Physicians/Neuromusculoskeletal Medicine Sports Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (89, '13', 'Physician/Neurology', '2084N0400X', 'Allopathic & Osteopathic Physicians/Psychiatry and Neurology Neurology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (90, '13', 'Physician/Neurology', '2084N0402X', 'Allopathic & Osteopathic Physicians/Psychiatry and Neurology Neurology with Special Qualifications in Child Neurology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (91, '13', 'Physician/Neurology', '2085N0700X', 'Allopathic & Osteopathic Physicians/Radiology/Neuroradiology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (92, '13', 'Physician/Neurology', '2084E0001X', 'Allopathic & Osteopathic Physicians/Psychiatry and Neurology Epilepsy');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (93, '13', 'Physician/Neurology', '2084A2900X', 'Allopathic & Osteopathic Physicians/Psychiatry & Neurology/Neurocritical Care');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (94, '14', 'Physician/Neurosurgery', '207T00000X', 'Allopathic & Osteopathic Physicians/Neurological Surgery');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (95, '15', 'Speech Language Pathologist', '235Z00000X', 'Speech Language and Hearing Service Providers   ');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (96, '16', 'Physician/Obstetrics & Gynecology', '207V00000X', 'Allopathic & Osteopathic Physicians/Obstetrics & Gynecology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (97, '16', 'Physician/Obstetrics & Gynecology', '207VB0002X', 'Allopathic & Osteopathic Physicians/Obstetrics & Gynecology Bariatric Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (98, '16', 'Physician/Obstetrics & Gynecology', '207VC0200X', 'Allopathic & Osteopathic Physicians/Obstetrics & Gynecology Critical Care Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (99, '16', 'Physician/Obstetrics & Gynecology', '207VF0040X', 'Allopathic & Osteopathic Physicians/Obstetrics & Gynecology Female Pelvic Medicine and Reconstructive Surgery');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (100, '16', 'Physician/Obstetrics & Gynecology', '207VX0201X', 'Allopathic & Osteopathic Physicians/Obstetrics & Gynecology Gynecologic Oncology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (101, '16', 'Physician/Obstetrics & Gynecology', '207VG0400X', 'Allopathic & Osteopathic Physicians/Obstetrics & Gynecology Gynecology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (102, '16', 'Physician/Obstetrics & Gynecology', '207VH0002X', 'Allopathic & Osteopathic Physicians/Obstetrics & Gynecology Hospice and Palliative Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (103, '16', 'Physician/Obstetrics & Gynecology', '207VM0101X', 'Allopathic & Osteopathic Physicians/Obstetrics & Gynecology Maternal & Fetal Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (104, '16', 'Physician/Obstetrics & Gynecology', '207VX0000X', 'Allopathic & Osteopathic Physicians/Obstetrics & Gynecology Obstetrics');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (105, '16', 'Physician/Obstetrics & Gynecology', '207VE0102X', 'Allopathic & Osteopathic Physicians/Obstetrics & Gynecology Reproductive Endocrinology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (106, '17', 'Physician/Hospice and Palliative Care', '2086H0002X', 'Allopathic & Osteopathic Physicians/Surgery/Hospice and Palliative Medicine General Surgery');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (368, '73', 'Mass Immunizer Roster Biller[2]', NULL, NULL);
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (107, '17', 'Physician/Hospice and Palliative Care', '207QH0002X', 'Allopathic & Osteopathic Physicians/Surgery/Hospice and Palliative Medicine Family Practice');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (108, '17', 'Physician/Hospice and Palliative Care', '207LH0002X', 'Allopathic & Osteopathic Physicians/Surgery/Hospice and Palliative Medicine Anesthesiology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (109, '17', 'Physician/Hospice and Palliative Care', '207RH0002X', 'Allopathic & Osteopathic Physicians/Surgery/Hospice and Palliative Medicine Internal Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (110, '17', 'Physician/Hospice and Palliative Care', '207VH0002X', 'Allopathic & Osteopathic Physicians/Surgery/Hospice and Palliative Medicine Obstetrics & Gynecology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (111, '17', 'Physician/Hospice and Palliative Care', '2084H0002X', 'Allopathic & Osteopathic Physicians/Surgery/Hospice and Palliative Medicine Neuropsychiatry');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (112, '17', 'Physician/Hospice and Palliative Care', '207PH0002X', 'Allopathic & Osteopathic Physicians/Surgery/Hospice and Palliative Medicine Emergency Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (113, '18', 'Physician/Ophthalmology', '207W00000X', 'Allopathic & Osteopathic Physicians/Ophthalmology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (114, '18', 'Physician/Ophthalmology', '207WX0009X', 'Allopathic & Osteopathic Physicians/Ophthalmology Glaucoma Specialist');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (115, '18', 'Physician/Ophthalmology', '207WX0107X', 'Allopathic & Osteopathic Physicians/Ophthalmology Retina Specialist');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (116, '18', 'Physician/Ophthalmology', '207WX0108X', 'Allopathic & Osteopathic Physicians/Ophthalmology Uveitis and Ocular Inflammatory Disease');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (117, '18', 'Physician/Ophthalmology', '207WX0109X', 'Allopathic & Osteopathic Physicians/Ophthalmology/Neuro-ophthalmology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (118, '18', 'Physician/Ophthalmology', '207WX0110X', 'Allopathic & Osteopathic Physicians/Ophthalmology/Pediatric Ophthalmology and Strabismus Specialist');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (119, '18', 'Physician/Ophthalmology', '207WX0120X', 'Allopathic & Osteopathic Physicians/Ophthalmology Cornea and External Diseases Specialist');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (120, '18', 'Physician/Ophthalmology', '207WX0200X', 'Allopathic & Osteopathic Physicians/Ophthalmic Plastic and Reconstructive Surgery');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (121, '19', 'Oral Surgery (Dentist only)', '1223S0112X', 'Allopathic & Osteopathic Physicians/Ophthalmology Dental Providers/Dentist Oral & Maxillofacial Surgery');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (122, '20', 'Physician/Orthopedic Surgery', '207X00000X', 'Allopathic & Osteopathic Physicians/Orthopedic Surgery');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (123, '20', 'Physician/Orthopedic Surgery', '207XS0114X', 'Allopathic & Osteopathic Physicians/Orthopedic Surgery Adult Reconstructive Orthopedic Surgery');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (124, '20', 'Physician/Orthopedic Surgery', '207XX0004X', 'Allopathic & Osteopathic Physicians/Orthopedic Surgery Foot and Ankle Surgery');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (125, '20', 'Physician/Orthopedic Surgery', '207XS0106X', 'Allopathic & Osteopathic Physicians/Orthopedic Surgery Hand Surgery');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (126, '20', 'Physician/Orthopedic Surgery', '207XS0117X', 'Allopathic & Osteopathic Physicians/Orthopedic Surgery Orthopedic Surgery of the Spine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (127, '20', 'Physician/Orthopedic Surgery', '207XX0801X', 'Allopathic & Osteopathic Physicians/Orthopedic Surgery Orthopedic Trauma');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (128, '20', 'Physician/Orthopedic Surgery', '207XP3100X', 'Allopathic & Osteopathic Physicians/Orthopedic Surgery Pediatric Orthopedic Surgery');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (129, '20', 'Physician/Orthopedic Surgery', '207XX0005X', 'Allopathic & Osteopathic Physicians/Orthopedic Surgery Sports Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (130, '21', 'Clinical Cardiac Electrophysiology', '207RC0001X', 'Allopathic & Osteopathic Physicians/Internal Medicine Clinical Cardiatric Electrophysiology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (131, '22', 'Physician/Pathology', '207ZP0101X', 'Allopathic & Osteopathic Physicians/Pathology Anatomic Pathology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (132, '22', 'Physician/Pathology', '207ZP0102X', 'Allopathic & Osteopathic Physicians/Pathology Anatomic Pathology & Clinical Pathology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (133, '22', 'Physician/Pathology', '207ZB0001X', 'Allopathic & Osteopathic Physicians/Pathology Blood Banking & Transfusion Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (134, '22', 'Physician/Pathology', '207ZP0104X', 'Allopathic & Osteopathic Physicians/Pathology Chemical Pathology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (135, '22', 'Physician/Pathology', '207ZC0006X', 'Allopathic & Osteopathic Physicians/Pathology Clinical Pathology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (136, '22', 'Physician/Pathology', '207ZP0105X', 'Allopathic & Osteopathic Physicians/Pathology Clinical Pathology/Laboratory Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (137, '22', 'Physician/Pathology', '207ZC0500X', 'Allopathic & Osteopathic Physicians/Pathology Cytopathology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (138, '22', 'Physician/Pathology', '207ZD0900X', 'Allopathic & Osteopathic Physicians/Pathology Dermapathology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (139, '22', 'Physician/Pathology', '207ZF0201X', 'Allopathic & Osteopathic Physicians/Pathology Forensic Pathology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (140, '22', 'Physician/Pathology', '207ZH0000X', 'Allopathic & Osteopathic Physicians/Pathology Hematology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (141, '22', 'Physician/Pathology', '207ZI0100X', 'Allopathic & Osteopathic Physicians/Pathology Immunopathology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (142, '22', 'Physician/Pathology', '207ZM0300X', 'Allopathic & Osteopathic Physicians/Pathology Medical Microbiology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (143, '22', 'Physician/Pathology', '207ZP0007X', 'Allopathic & Osteopathic Physicians/Pathology Molecular Genetic Pathology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (144, '22', 'Physician/Pathology', '207ZN0500X', 'Allopathic & Osteopathic Physicians/Pathology Neuropathology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (145, '22', 'Physician/Pathology', '207ZP0213X', 'Allopathic & Osteopathic Physicians/Pathology Pediatric Pathology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (146, '22', 'Physician/Pathology', '207ZC0008X', 'Allopathic & Osteopathic Physicians/Pathology/Clinical Informatics');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (147, '23', 'Physician/Sports Medicine', '207XX0005X', 'Allopathic & Osteopathic Physicians/Orthopedic Surgery/Sports Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (148, '23', 'Physician/Sports Medicine', '207PS0010X', 'Allopathic & Osteopathic Physicians/Emergency Medicine Sports Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (149, '23', 'Physician/Sports Medicine', '207QS0010X', 'Allopathic & Osteopathic Physicians/Family Medicine Sports Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (150, '23', 'Physician/Sports Medicine', '207RS0010X', 'Allopathic & Osteopathic Physicians/Internal Medicine Sports Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (151, '23', 'Physician/Sports Medicine', '204C00000X', 'Allopathic & Osteopathic Physicians/Neuromusculoskeletal Medicine Sports Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (152, '23', 'Physician/Sports Medicine', '2080S0010X', 'Allopathic & Osteopathic Physicians/Pediatrics Sports Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (153, '23', 'Physician/Sports Medicine', '2081P0301X', 'Allopathic & Osteopathic Physicians/Physical Medicine & Rehabilitation Brain Injury');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (154, '23', 'Physician/Sports Medicine', '2081S0010X', 'Allopathic & Osteopathic Physicians/Physical Medicine & Rehabilitation Sports Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (155, '23', 'Physician/Sports Medicine', '2083S0010X', 'Allopathic & Osteopathic Physicians/Preventive Medicine Sports Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (156, '23', 'Physician/Sports Medicine', '2084S0010X', 'Allopathic & Osteopathic Physicians/ Psychiatry & Neurology Sports Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (157, '24', 'Physician/Plastic and Reconstructive Surgery', '208200000X', 'Allopathic & Osteopathic Physicians/Plastic Surgery');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (158, '24', 'Physician/Plastic and Reconstructive Surgery', '2082S0099X', 'Allopathic & Osteopathic Physicians/Plastic Surgery Plastic Surgery Within the Head and Neck');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (159, '24', 'Physician/Plastic and Reconstructive Surgery', '2082S0105X', 'Allopathic & Osteopathic Physicians/Plastic Surgery Surgery of the Hand');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (160, '25', 'Physician/Physical Medicine and Rehabilitation', '208100000X', 'Allopathic & Osteopathic Physicians/Physical Medicine & Rehabilitation');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (161, '25', 'Physician/Physical Medicine and Rehabilitation', '2081H0002X', 'Allopathic & Osteopathic Physicians/Physical Medicine & Rehabilitation Hospice and Palliative Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (162, '25', 'Physician/Physical Medicine and Rehabilitation', '2081N0008X', 'Allopathic & Osteopathic Physicians/Physical Medicine & Rehabilitation Neuromuscular Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (163, '25', 'Physician/Physical Medicine and Rehabilitation', '2081P2900X', 'Allopathic & Osteopathic Physicians/Physical Medicine & Rehabilitation Pain Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (164, '25', 'Physician/Physical Medicine and Rehabilitation', '2081P0010X', 'Allopathic & Osteopathic Physicians/Physical Medicine & Rehabilitation Pediatric Rehabilitation Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (165, '25', 'Physician/Physical Medicine and Rehabilitation', '2081P0004X', 'Allopathic & Osteopathic Physicians/Physical Medicine & Rehabilitation Spinal Cord Injury Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (166, '25', 'Physician/Physical Medicine and Rehabilitation', '2081S0010X', 'Allopathic & Osteopathic Physicians/Physical Medicine & Rehabilitation Sports Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (167, '26', 'Physician/Psychiatry', '2084P0800X', 'Allopathic & Osteopathic Physicians/Psychiatry');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (168, '26', 'Physician/Psychiatry', '2084P0301X', 'Allopathic & Osteopathic Physicians/Psychiatry & Neurology/Respiratory Developmental Rehabilitative and Restorative Service  Brain Injury Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (169, '27', 'Physician/Geriatric Psychiatry', '207QG0300X', 'Allopathic & Osteopathic Physicians/Family Medicine Geriatric Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (170, '28', 'Physician/Colorectal Surgery (Proctology)', '208C00000X', 'Allopathic & Osteopathic Physicians/Colon & Rectal Surgery');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (171, '29', 'Physician/Pulmonary Disease', '207RP1001X', 'Allopathic & Osteopathic Physicians/Internal Medicine Pulmonary Disease');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (172, '30', 'Physician/Diagnostic Radiology', '2085R0202X', 'Allopathic & Osteopathic Physicians/Radiology Diagnostic Radiology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (173, '30', 'Physician/Diagnostic Radiology', '2085R0205X', 'Allopathic & Osteopathic Physicians/Radiology Radiological Physics');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (174, '30', 'Physician/Diagnostic Radiology', '2085U0001X', 'Allopathic & Osteopathic Physicians/Radiology Diagnostic Ultrasound');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (175, '30', 'Physician/Diagnostic Radiology', '2085D0003X', 'Allopathic & Osteopathic Physicians/Radiology Diagnostic Neuroimaging');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (176, '30', 'Physician/Diagnostic Radiology', '2085P0229X', 'Allopathic & Osteopathic Physicians/Radiology Pediatric Radiology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (177, '31', 'Intensive Cardiac Rehabilitation', '163WC3500X', 'Nursing Service Providers Registered Nurse Cardiac Rehabilitation');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (178, '32', 'Anesthesiology Assistant', '367H00000X', 'Physician Assistants & Advanced Practice Nursing Providers/Anesthesiologist Assistant');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (179, '33', 'Physician/Thoracic Surgery', '208G00000X', 'Allopathic & Osteopathic Physicians/Thoracic Surgery (Cardiothoracic Vascular Surgery)');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (180, '34', 'Physician/Urology', '208800000X', 'Allopathic & Osteopathic Physicians/Urology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (181, '34', 'Physician/Urology', '2088P0231X', 'Allopathic & Osteopathic Physicians/Urology Pediatric Urology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (182, '34', 'Physician/Urology', '2088F0040X', 'Female Pelvic Medicine & Reconstructive Surgery');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (183, '35', 'Chiropractic', '111N00000X', 'Chiropractic Providers/Chiropractor');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (184, '35', 'Chiropractic', '111NI0013X', 'Chiropractic Providers/Chiropractor Independent Medical Examiner');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (185, '35', 'Chiropractic', '111NI0900X', 'Chiropractic Providers/Chiropractor Internist');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (186, '35', 'Chiropractic', '111NN0400X', 'Chiropractic Providers/Chiropractor Neurology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (187, '35', 'Chiropractic', '111NN1001X', 'Chiropractic Providers/Chiropractor Nutrition');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (188, '35', 'Chiropractic', '111NX0100X', 'Chiropractic Providers/Chiropractor Occupational Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (189, '35', 'Chiropractic', '111NX0800X', 'Chiropractic Providers/Chiropractor Orthopedic');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (190, '35', 'Chiropractic', '111NP0017X', 'Chiropractic Providers/Chiropractor Pediatric Chiropractor');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (191, '35', 'Chiropractic', '111NR0200X', 'Chiropractic Providers/Chiropractor Radiology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (192, '35', 'Chiropractic', '111NR0400X', 'Chiropractic Providers/Chiropractor Rehabilitation');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (193, '35', 'Chiropractic', '111NS0005X', 'Chiropractic Providers/Chiropractor Sports Physician');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (194, '35', 'Chiropractic', '111NT0100X', 'Chiropractic Providers/Chiropractor Thermography');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (195, '36', 'Physician/Nuclear Medicine', '207U00000X', 'Allopathic & Osteopathic Physicians/Nuclear Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (196, '36', 'Physician/Nuclear Medicine', '2085N0904X', 'Allopathic & Osteopathic Physicians/Radiology/Neuroradiology/Nuclear Radiology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (197, '36', 'Physician/Nuclear Medicine', '207UN0903X', 'Allopathic & Osteopathic Physicians/Nuclear Medicine In Vivo & In Vitro Nuclear Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (198, '36', 'Physician/Nuclear Medicine', '207UN0901X', 'Allopathic & Osteopathic Physicians/Nuclear Medicine Nuclear Cardiology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (199, '36', 'Physician/Nuclear Medicine', '207UN0902X', 'Allopathic & Osteopathic Physicians/Nuclear Medicine Nuclear Imaging & Therapy');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (200, '37', 'Physician/Pediatric Medicine', '208000000X', 'Allopathic & Osteopathic Physicians/Pediatrics');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (201, '37', 'Physician/Pediatric Medicine', '2080A0000X', 'Allopathic & Osteopathic Physicians/Pediatrics Adolescent Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (202, '37', 'Physician/Pediatric Medicine', '2080I0007X', 'Allopathic & Osteopathic Physicians/Pediatrics Clinical & Laboratory Immunology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (203, '37', 'Physician/Pediatric Medicine', '2080P0006X', 'Allopathic & Osteopathic Physicians/Pediatrics DevelopmentalBehavioral Pediatrics');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (204, '37', 'Physician/Pediatric Medicine', '2080H0002X', 'Allopathic & Osteopathic Physicians/Pediatrics Hospice and Palliative Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (205, '37', 'Physician/Pediatric Medicine', '2080T0002X', 'Allopathic & Osteopathic Physicians/Pediatrics Medical Toxicology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (206, '37', 'Physician/Pediatric Medicine', '2080N0001X', 'Allopathic & Osteopathic Physicians/Pediatrics Neonatal-Perinatal Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (207, '37', 'Physician/Pediatric Medicine', '2080P0008X', 'Allopathic & Osteopathic Physicians/Pediatrics Neurodevelopmental Disabilities');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (208, '37', 'Physician/Pediatric Medicine', '2080P0201X', 'Allopathic & Osteopathic Physicians/Pediatrics Pediatric Allergy & Immunology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (209, '37', 'Physician/Pediatric Medicine', '2080P0202X', 'Allopathic & Osteopathic Physicians/Pediatrics Pediatric Cardiology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (210, '37', 'Physician/Pediatric Medicine', '2080P0203X', 'Allopathic & Osteopathic Physicians/Pediatrics Pediatric Critical Care Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (211, '37', 'Physician/Pediatric Medicine', '2080P0204X', 'Allopathic & Osteopathic Physicians/Pediatrics Pediatric Emergency Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (212, '37', 'Physician/Pediatric Medicine', '2080P0205X', 'Allopathic & Osteopathic Physicians/Pediatrics Pediatric Endocrinology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (213, '37', 'Physician/Pediatric Medicine', '2080P0206X', 'Allopathic & Osteopathic Physicians/Pediatrics Pediatric Gastroenterology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (214, '37', 'Physician/Pediatric Medicine', '2080P0207X', 'Allopathic & Osteopathic Physicians/Pediatrics Pediatric Hematology-Oncology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (215, '37', 'Physician/Pediatric Medicine', '2080P0208X', 'Allopathic & Osteopathic Physicians/Pediatrics Pediatric Infectious Diseases');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (216, '37', 'Physician/Pediatric Medicine', '2080P0210X', 'Allopathic & Osteopathic Physicians/Pediatrics Pediatric Nephrology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (217, '37', 'Physician/Pediatric Medicine', '2080P0214X', 'Allopathic & Osteopathic Physicians/Pediatrics Pediatric Pulmonology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (218, '37', 'Physician/Pediatric Medicine', '2080P0216X', 'Allopathic & Osteopathic Physicians/Pediatrics Pediatric Rheumatology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (219, '37', 'Physician/Pediatric Medicine', '2080T0004X', 'Allopathic & Osteopathic Physicians/Pediatrics Pediatric Transplant Hepatology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (220, '37', 'Physician/Pediatric Medicine', '2080S0012X', 'Allopathic & Osteopathic Physicians/Pediatrics Sleep Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (221, '37', 'Physician/Pediatric Medicine', '2080S0010X', 'Allopathic & Osteopathic Physicians/Pediatrics Sports Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (222, '37', 'Physician/Pediatric Medicine', '2080B0002X', 'Allopathic & Osteopathic Physicians/Pediatrics/Obesity Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (223, '37', 'Physician/Pediatric Medicine', '2080C0008X', 'Allopathic & Osteopathic Physicians/Pediatrics/Child Abuse Pediatrics');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (224, '38', 'Physician/Geriatric Medicine', '207RG0300X', 'Allopathic & Osteopathic Physicians/Internal Medicine Geriatric Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (225, '38', 'Physician/Geriatric Medicine', '207QG0300X', 'Allopathic & Osteopathic Physicians/Family Medicine Geriatric Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (226, '39', 'Physician/Nephrology', '207RN0300X', 'Allopathic & Osteopathic Physicians/Internal Medicine Nephrology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (227, '40', 'Physician/Hand Surgery', '2086S0105X', 'Allopathic & Osteopathic Physicians/Surgery Surgery of the Hand');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (228, '40', 'Physician/Hand Surgery', '2082S0105X', 'Allopathic & Osteopathic Physicians/Plastic Surgery Surgery of the Hand');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (229, '41', 'Optometry', '152W00000X', 'Eye and Vision Service Providers/Optometrist');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (230, '41', 'Optometry', '152WC0802X', 'Eye and Vision Service Providers/Optometrist Corneal and Contact Management');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (231, '41', 'Optometry', '152WL0500X', 'Eye and Vision Service Providers/Optometrist Low Vision Rehabilitation');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (232, '41', 'Optometry', '152WX0102X', 'Eye and Vision Service Providers/Optometrist Occupational Vision');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (233, '41', 'Optometry', '152WP0200X', 'Eye and Vision Service Providers/Optometrist Pediatrics');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (234, '41', 'Optometry', '152WS0006X', 'Eye and Vision Service Providers/Optometrist Sports Vision');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (235, '41', 'Optometry', '152WV0400X', 'Eye and Vision Service Providers/Optometrist Vision Therapy');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (236, '42', 'Certified Nurse Midwife', '367A00000X', 'Physician Assistants & Advanced Practice Nursing Providers/Midwife Certified Nurse');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (237, '43', 'Certified Registered Nurse Anesthetist (CRNA)', '367500000X', 'Physician Assistants & Advanced Practice Nursing Providers/Nurse Anesthetist Certified Registered ');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (238, '44', 'Physician/Infectious Disease', '207RI0200X', 'Allopathic & Osteopathic Physicians/Internal Medicine Infectious Disease');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (239, '45', 'Mammography Center', '261QR0208X', 'Ambulatory Health Care Facilities/Clinic-Center Radiology Mammography');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (240, '45', 'Mammography Center', '261QR0207X', 'Ambulatory Health Care Facilities/Clinic-Center Radiology Mobile Mammography');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (241, '46', 'Physician/Endocrinology', '207RE0101X', 'Allopathic & Osteopathic Physicians/Internal Medicine Endocrinology Diabetes & Metabolism');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (242, '47', 'Independent Diagnostic Testing Facility (IDTF)', '293D00000X', 'Laboratories/Physiological Laboratory');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (243, '48', 'Podiatry', '213E00000X', 'Podiatric Medicine & Surgery Service Providers/Podiatrist');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (244, '48', 'Podiatry', '213ES0103X', 'Podiatric Medicine & Surgery Service Providers/Podiatrist Foot & Ankle Surgery');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (245, '48', 'Podiatry', '213ES0131X', 'Podiatric Medicine & Surgery Service Providers/Podiatrist Foot Surgery');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (246, '48', 'Podiatry', '213EG0000X', 'Podiatric Medicine & Surgery Service Providers/Podiatrist General Practice');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (247, '48', 'Podiatry', '213EP1101X', 'Podiatric Medicine & Surgery Service Providers/Podiatrist Primary Podiatric Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (248, '48', 'Podiatry', '213EP0504X', 'Podiatric Medicine & Surgery Service Providers/Podiatrist Public Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (249, '48', 'Podiatry', '213ER0200X', 'Podiatric Medicine & Surgery Service Providers/Podiatrist Radiology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (250, '48', 'Podiatry', '213ES0000X', 'Podiatric Medicine & Surgery Service Providers/Podiatrist Sports Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (251, '49', 'Ambulatory Surgical Center', '261QA1903X', 'Ambulatory Health Care Facilities/Clinic-Center Ambulatory Surgical');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (252, '50', 'Nurse Practitioner', '363L00000X', 'Physician Assistants & Advanced Practice Nursing Providers/Nurse Practitioner');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (253, '50', 'Nurse Practitioner', '363LA2100X', 'Physician Assistants & Advanced Practice Nursing Providers/Nurse Practitioner Acute Care');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (254, '50', 'Nurse Practitioner', '363LA2200X', 'Physician Assistants & Advanced Practice Nursing Providers/Nurse Practitioner Adult Health');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (255, '50', 'Nurse Practitioner', '363LC1500X', 'Physician Assistants & Advanced Practice Nursing Providers/Nurse Practitioner Community Health');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (256, '50', 'Nurse Practitioner', '363LC0200X', 'Physician Assistants & Advanced Practice Nursing Providers/Nurse Practitioner Critical Care Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (257, '50', 'Nurse Practitioner', '363LF0000X', 'Physician Assistants & Advanced Practice Nursing Providers/Nurse Practitioner Family');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (258, '50', 'Nurse Practitioner', '363LG0600X', 'Physician Assistants & Advanced Practice Nursing Providers/Nurse Practitioner Gerontology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (259, '50', 'Nurse Practitioner', '363LN0000X', 'Physician Assistants & Advanced Practice Nursing Providers/Nurse Practitioner Neonatal');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (260, '50', 'Nurse Practitioner', '363LN0005X', 'Physician Assistants & Advanced Practice Nursing Providers/Nurse Practitioner Neonatal Critical Care');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (261, '50', 'Nurse Practitioner', '363LX0001X', 'Physician Assistants & Advanced Practice Nursing Providers/Nurse Practitioner Obstetrics & Gynecology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (262, '50', 'Nurse Practitioner', '363LX0106X', 'Physician Assistants & Advanced Practice Nursing Providers/Nurse Practitioner Occupational Health');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (263, '50', 'Nurse Practitioner', '363LP0200X', 'Physician Assistants & Advanced Practice Nursing Providers/Nurse Practitioner Pediatrics');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (264, '50', 'Nurse Practitioner', '363LP0222X', 'Physician Assistants & Advanced Practice Nursing Providers/Nurse Practitioner Pediatrics Critical Care');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (265, '50', 'Nurse Practitioner', '363LP1700X', 'Physician Assistants & Advanced Practice Nursing Providers/Nurse Practitioner Perinatal');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (266, '50', 'Nurse Practitioner', '363LP2300X', 'Physician Assistants & Advanced Practice Nursing Providers/Nurse Practitioner Primary Care');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (267, '50', 'Nurse Practitioner', '363LP0808X', 'Physician Assistants & Advanced Practice Nursing Providers/Nurse Practitioner Psychiatric/Mental Health');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (268, '50', 'Nurse Practitioner', '363LS0200X', 'Physician Assistants & Advanced Practice Nursing Providers/Nurse Practitioner School');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (269, '50', 'Nurse Practitioner', '363LW0102X', 'Physician Assistants & Advanced Practice Nursing Providers/Nurse Practitioner Womens Health');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (270, '51', 'Medical Supply Company with Orthotist', '335E00000X', 'Suppliers/Prosthetic/Orthotic Supplier');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (271, '52', 'Medical Supply Company with Prosthetist', '335E00000X', 'Suppliers/Prosthetic/Orthotic Supplier');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (272, '53', 'Medical Supply Company with Orthotist-Prosthetist', '335E00000X', 'Suppliers/Prosthetic/Orthotic Supplier');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (273, '54', 'Other Medical Supply Company', '332B00000X', 'Suppliers/Durable Medical Equipment & Medical Supplies');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (274, '55', 'Individual Certified Orthotist', '222Z00000X', 'Respiratory Developmental Rehabilitative and Restorative Service Providers/Orthotist');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (275, '56', 'Individual Certified Prosthetist', '224P00000X', 'Respiratory, Developmental, Rehabilitative, and Restorative Service Providers/Prosthetist');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (276, '56', 'Individual Certified Prosthetist', '29N00000X', 'Respiratory, Developmental, Rehabilitative, and Restorative Service Providers/Anaplastologist');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (277, '57', 'Individual Certified Prosthetist-Orthotist', '222Z00000X', 'Respiratory Developmental Rehabilitative and Restorative Service Providers/Orthotist');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (278, '57', 'Individual Certified Prosthetist-Orthotist', '229N00000X', 'Respiratory Developmental Rehabilitative and Restorative Service Providers/Anaplastologist');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (279, '57', 'Individual Certified Prosthetist-Orthotist', '224P00000X', 'Respiratory Developmental Rehabilitative and Restorative Service Providers/Prosthetist');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (280, '58', 'Medical Supply Company with Pharmacist', '332B00000X', 'Suppliers/Durable Medical Equipment & Medical Supplies');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (281, '58', 'Medical Supply Company with Pharmacist', '333600000X', 'Suppliers/Pharmacy');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (282, '58', 'Medical Supply Company with Pharmacist', '3336C0002X', 'Suppliers/Pharmacy Clinic Pharmacy');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (283, '58', 'Medical Supply Company with Pharmacist', '3336C0003X', 'Suppliers/Pharmacy Community/Retail Pharmacy');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (284, '58', 'Medical Supply Company with Pharmacist', '3336C0004X', 'Suppliers/Pharmacy Compounding Pharmacy');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (285, '58', 'Medical Supply Company with Pharmacist', '3336H0001X', 'Suppliers/Pharmacy Home Infusion Therapy Pharmacy');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (286, '58', 'Medical Supply Company with Pharmacist', '3336I0012X', 'Suppliers/Pharmacy Institutional Pharmacy');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (287, '58', 'Medical Supply Company with Pharmacist', '3336L0003X', 'Suppliers/Pharmacy Long-term Care Pharmacy');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (288, '58', 'Medical Supply Company with Pharmacist', '3336M0002X', 'Suppliers/Pharmacy Mail Order Pharmacy');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (289, '58', 'Medical Supply Company with Pharmacist', '3336M0003X', 'Suppliers/Pharmacy Managed Care Organization Pharmacy');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (290, '58', 'Medical Supply Company with Pharmacist', '3336N0007X', 'Suppliers/Pharmacy Nuclear Pharmacy');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (291, '58', 'Medical Supply Company with Pharmacist', '3336S0011X', 'Suppliers/Pharmacy Specialty Pharmacy');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (292, '59', 'Ambulance Service Provider', '341600000X', 'Transportation Services/Ambulance');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (293, '59', 'Ambulance Service Provider', '3416A0800X', 'Transportation Services/Ambulance Air Transport');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (294, '59', 'Ambulance Service Provider', '3416L0300X', 'Transportation Services/Ambulance Land Transport');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (295, '59', 'Ambulance Service Provider', '3416S0300X', 'Transportation Services/Ambulance Water Transport');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (296, '60', 'Public Health or Welfare Agency', '251K00000X', 'Agencies/Public Health or Welfare');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (297, '61', 'Voluntary Health or Charitable Agency[1]', '251V00000X', 'Agencies/Voluntary or Charitable');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (298, '62', 'Psychologist Clinical', '103T00000X', 'Behavioral Health & Social Service Providers/Psychologist');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (299, '62', 'Psychologist Clinical', '103TA0400X', 'Behavioral Health & Social Service Providers/Psychologist Addiction (Substance Abuse Disorder)');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (300, '62', 'Psychologist Clinical', '103TA0700X', 'Behavioral Health & Social Service Providers/Psychologist Adult Development & Aging');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (301, '62', 'Psychologist Clinical', '103TC0700X', 'Behavioral Health & Social Service Providers/Psychologist Clinical');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (302, '62', 'Psychologist Clinical', '103TC2200X', 'Behavioral Health & Social Service Providers/Psychologist Clinical Child & Adolescent');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (303, '62', 'Psychologist Clinical', '103TB0200X', 'Behavioral Health & Social Service Providers/Psychologist Cognitive & Behavioral');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (304, '62', 'Psychologist Clinical', '103TC1900X', 'Behavioral Health & Social Service Providers/Psychologist Counseling');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (305, '62', 'Psychologist Clinical', '103TE1000X', 'Behavioral Health & Social Service Providers/Psychologist Educational');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (306, '62', 'Psychologist Clinical', '103TE1100X', 'Behavioral Health & Social Service Providers/Psychologist Exercise & Sports');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (307, '62', 'Psychologist Clinical', '103TF0000X', 'Behavioral Health & Social Service Providers/Psychologist Family');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (308, '62', 'Psychologist Clinical', '103TF0200X', 'Behavioral Health & Social Service Providers/Psychologist Forensic');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (309, '62', 'Psychologist Clinical', '103TP2701X', 'Behavioral Health & Social Service Providers/Psychologist Group Psychotherapy');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (310, '62', 'Psychologist Clinical', '103TH0004X', 'Behavioral Health & Social Service Providers/Psychologist Health');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (311, '62', 'Psychologist Clinical', '103TH0100X', 'Behavioral Health & Social Service Providers/Psychologist Health Service');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (312, '62', 'Psychologist Clinical', '103TM1700X', 'Behavioral Health & Social Service Providers/Psychologist Men & Masculinity');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (313, '62', 'Psychologist Clinical', '103TM1800X', 'Behavioral Health & Social Service Providers/Psychologist Intellectual & Developmental Disabilities ');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (314, '62', 'Psychologist Clinical', '103TP0016X', 'Behavioral Health & Social Service Providers/Psychologist Prescribing (Medical)');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (315, '62', 'Psychologist Clinical', '103TP0814X', 'Behavioral Health & Social Service Providers/Psychologist Psychoanalysis');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (316, '62', 'Psychologist Clinical', '103TP2700X', 'Behavioral Health & Social Service Providers/Psychologist Psychotherapy');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (317, '62', 'Psychologist Clinical', '103TR0400X', 'Behavioral Health & Social Service Providers/Psychologist Rehabilitation');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (318, '62', 'Psychologist Clinical', '103TS0200X', 'Behavioral Health & Social Service Providers/Psychologist School');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (319, '62', 'Psychologist Clinical', '103TW0100X', 'Behavioral Health & Social Service Providers/Psychologist Women');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (320, '62', 'Psychologist Clinical', '106E00000X', 'Behavioral Health & Social Service Providers/Assistant Behavior Analyst');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (321, '62', 'Psychologist Clinical', '106S00000X', 'Behavioral Health & Social Service Providers/Technician');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (322, '63', 'Portable X-Ray Supplier', '335V00000X', 'Suppliers/Portable X-Ray Supplier');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (323, '64', 'Audiologist', '231H00000X', 'Speech Language and Hearing Service Providers/Audiologist');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (324, '64', 'Audiologist', '231HA2500X', 'Speech Language and Hearing Service Providers/Audiologist/Assistive Technology Supplier');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (325, '64', 'Audiologist', '231HA2400X', 'Speech Language and Hearing Service Providers/Audiologist Assistive Technology Practitioner');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (326, '65', 'Physical Therapist in Private Practice', '225100000X', 'Respiratory Developmental Rehabilitative & Restorative Service Providers/Physical Therapist');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (327, '65', 'Physical Therapist in Private Practice', '2251C2600X', 'Respiratory Developmental Rehabilitative & Restorative Service Providers/Physical Therapist Cardiopulmonary');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (328, '65', 'Physical Therapist in Private Practice', '2251E1300X', 'Respiratory Developmental Rehabilitative & Restorative Service Providers/Physical Therapist Electrophysiology Clinical');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (329, '65', 'Physical Therapist in Private Practice', '2251E1200X', 'Respiratory Developmental Rehabilitative & Restorative Service Providers/Physical Therapist Ergonomics');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (330, '65', 'Physical Therapist in Private Practice', '2251G0304X', 'Respiratory Developmental Rehabilitative & Restorative Service Providers/Physical Therapist Geriatrics');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (331, '65', 'Physical Therapist in Private Practice', '2251H1200X', 'Respiratory Developmental Rehabilitative & Restorative Service Providers/Physical Therapist Hand');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (332, '65', 'Physical Therapist in Private Practice', '2251H1300X', 'Respiratory Developmental Rehabilitative & Restorative Service Providers/Physical Therapist Human Factors');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (333, '65', 'Physical Therapist in Private Practice', '2251N0400X', 'Respiratory Developmental Rehabilitative & Restorative Service Providers/Physical Therapist Neurology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (334, '65', 'Physical Therapist in Private Practice', '2251X0800X', 'Respiratory Developmental Rehabilitative & Restorative Service Providers/Physical Therapist Orthopedic');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (335, '65', 'Physical Therapist in Private Practice', '2251P0200X', 'Respiratory Developmental Rehabilitative & Restorative Service Providers/Physical Therapist Pediatrics');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (336, '65', 'Physical Therapist in Private Practice', '2251S0007X', 'Respiratory Rehabilitative & Restorative Service Providers/Physical Therapist Sports');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (337, '66', 'Physician/Rheumatology', '207RR0500X', 'Allopathic & Osteopathic Physicians/Internal Medicine Rheumatology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (338, '67', 'Occupational Therapist in Private Practice', '225X00000X', 'Respiratory Developmental Rehabilitative & Restorative Service Providers/Occupational Therapist');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (339, '67', 'Occupational Therapist in Private Practice', '225XR0403X', 'Respiratory Developmental Rehabilitative & Restorative Service Providers/Occupational Therapist Driving and Community Mobility');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (340, '67', 'Occupational Therapist in Private Practice', '225XE0001X', 'Respiratory Developmental Rehabilitative & Restorative Service Providers/Occupational Therapist Environmental Modification');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (341, '67', 'Occupational Therapist in Private Practice', '225XE1200X', 'Respiratory Developmental Rehabilitative & Restorative Service Providers/Occupational Therapist Ergonomics');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (342, '67', 'Occupational Therapist in Private Practice', '225XF0002X', 'Respiratory Developmental Rehabilitative & Restorative Service Providers/Occupational Therapist Feeding Eating &Swallowing');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (343, '67', 'Occupational Therapist in Private Practice', '225XG0600X', 'Respiratory Developmental Rehabilitative & Restorative Service Providers/Occupational Therapist Gerontology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (344, '67', 'Occupational Therapist in Private Practice', '225XH1200X', 'Respiratory Developmental Rehabilitative & Restorative Service Providers/Occupational Therapist Hand');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (345, '67', 'Occupational Therapist in Private Practice', '225XH1300X', 'Respiratory Developmental Rehabilitative & Restorative Service Providers/Occupational Therapist Human Factors');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (346, '67', 'Occupational Therapist in Private Practice', '225XL0004X', 'Respiratory Developmental Rehabilitative & Restorative Service Providers/Occupational Therapist Low Vision');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (347, '67', 'Occupational Therapist in Private Practice', '225XM0800X', 'Respiratory Developmental Rehabilitative & Restorative Service Providers/Occupational Therapist Mental Health');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (348, '67', 'Occupational Therapist in Private Practice', '225XN1300X', 'Respiratory Developmental Rehabilitative & Restorative Service Providers/Occupational Therapist Neurorehabilitation');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (349, '67', 'Occupational Therapist in Private Practice', '225XP0200X', 'Respiratory Developmental Rehabilitative & Restorative Service Providers/Occupational Therapist Pediatrics');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (350, '67', 'Occupational Therapist in Private Practice', '225XP0019X', 'Respiratory Developmental Rehabilitative & Restorative Service Providers/Occupational Therapist Physical Rehabilitation');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (351, '68', 'Psychologist Clinical', '103TC0700X', 'Behavioral Health & Social Service Providers/Psychologist Clinical');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (352, '69', 'Clinical Laboratory', '291U00000X', 'Laboratories/Clinical Medical Laboratory');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (353, '70', 'Clinic or Group Practice', '261QM1300X', 'Ambulatory Health Care Facilities/Clinic/Center Multi-Specialty  ');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (354, '70', 'Clinic or Group Practice', '261QP2000X', 'Ambulatory Health Care Facilities/Clinic/Center Physical Therapy');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (355, '70', 'Clinic or Group Practice', '193200000X', 'Group/Multi-Specialty');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (356, '70', 'Clinic or Group Practice', '261Q00000X', 'Ambulatory Health Care Facilities/Clinic/Center Multi-Specialty  ');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (357, '70', 'Clinic or Group Practice', '193400000X', 'Group/Single-Specialty');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (358, '71', 'Registered Dietitian or Nutrition Professional', '133V00000X', 'Dietary & Nutritional Service Providers/Dietician Registered');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (359, '71', 'Registered Dietitian or Nutrition Professional', '133VN1006X', 'Dietary & Nutritional Service Providers/Dietician Registered Nutrition Metabolic');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (360, '71', 'Registered Dietitian or Nutrition Professional', '133VN1004X', 'Dietary & Nutritional Service Providers/Dietician Registered Nutrition Pediatric');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (361, '71', 'Registered Dietitian or Nutrition Professional', '133VN1005X', 'Dietary & Nutritional Service Providers/Dietician Registered Nutrition Renal');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (362, '71', 'Registered Dietitian or Nutrition Professional', '133VN1101X', 'Dietary & Nutritional Service Providers/Dietician Registered Nutrition Gerontological');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (363, '71', 'Registered Dietitian or Nutrition Professional', '133VN1201X', 'Dietary & Nutritional Service Providers/Dietician Registered Nutrition Obesity and Weight Management');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (364, '71', 'Registered Dietitian or Nutrition Professional', '133VN1301X', 'Dietary & Nutritional Service Providers/Dietician Registered Nutrition Oncology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (365, '71', 'Registered Dietitian or Nutrition Professional', '133VN1401X', 'Dietary & Nutritional Service Providers/Dietician Registered Nutrition Pediatric Critical Care');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (366, '71', 'Registered Dietitian or Nutrition Professional', '133VN1501X', 'Dietary & Nutritional Service Providers/Dietician Registered Nutrition Sports Dietetics');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (367, '72', 'Physician/Pain Management', '133VN1501X', 'Allopathic & Osteopathic Physicians/Pain Medicine Pain Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (369, '74', 'Radiation Therapy Center', '261QR0200X', 'Ambulatory Health Care Facilities/Clinic/Center Radiology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (370, '75', 'Slide Preparation Facility', '247200000X', 'Technologists Technicians & Other Technical Service Providers/Technician Other');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (371, '76', 'Physician/Peripheral Vascular Disease', '2086S0129X', 'Allopathic & Osteopathic Physicians/Surgery Vascular Surgery');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (372, '77', 'Physician/Vascular Surgery', '2086S0129X', 'Allopathic & Osteopathic Physicians/Surgery Vascular Surgery');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (373, '78', 'Physician/Cardiac Surgery', '208G00000X', 'Allopathic & Osteopathic Physicians/Thoracic Surgery (Cardiothoracic Vascular Surgery)');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (374, '79', 'Physician/Addiction Medicine', '207L00000X', 'Allopathic & Osteopathic Physicians/Anesthesiology Addiction Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (375, '79', 'Physician/Addiction Medicine', '207QA0401X', 'Allopathic & Osteopathic Physicians/Family Medicine Addiction Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (376, '79', 'Physician/Addiction Medicine', '207RA0401X', 'Allopathic & Osteopathic Physicians/Internal Medicine Addiction Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (377, '79', 'Physician/Addiction Medicine', '2084A0401X', 'Allopathic & Osteopathic Physicians/Psychiatry & Neurology Addiction Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (378, '80', 'Licensed Clinical Social Worker', '1041C0700X', 'Behavioral Health & Social Service Providers/Social Worker Clinical');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (379, '81', 'Physician/Critical Care (Intensivists)', '207RC0200X', 'Allopathic & Osteopathic Physicians/Internal Medicine Critical Care Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (380, '82', 'Physician/Hematology', '207RH0000X', 'Allopathic & Osteopathic Physicians/Internal Medicine Hematology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (381, '83', 'Physician/Hematology-Oncology', '207RH0003X', 'Allopathic & Osteopathic Physicians/Internal Medicine Hematology & Oncology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (382, '84', 'Physician/Preventive Medicine', '2083A0100X', 'Allopathic & Osteopathic Physicians/Preventive Medicine Aerospace Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (383, '84', 'Physician/Preventive Medicine', '2083T0002X', 'Allopathic & Osteopathic Physicians/Preventive Medicine Medical Toxicology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (384, '84', 'Physician/Preventive Medicine', '2083X0100X', 'Allopathic & Osteopathic Physicians/Preventive Medicine Occupational Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (385, '84', 'Physician/Preventive Medicine', '2083P0500X', 'Allopathic & Osteopathic Physicians/Preventive Medicine  Preventive Medicine/Occupational Environmental Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (386, '84', 'Physician/Preventive Medicine', '2083P0901X', 'Allopathic & Osteopathic Physicians/Preventive Medicine Public Health & General Preventive Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (387, '84', 'Physician/Preventive Medicine', '2083S0010X', 'Allopathic & Osteopathic Physicians/Preventive Medicine Sports Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (388, '84', 'Physician/Preventive Medicine', '2083P0011X', 'Allopathic & Osteopathic Physicians/Preventive Medicine Undersea and Hyperbaric Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (389, '84', 'Physician/Preventive Medicine', '2083A0300X', 'Allopathic & Osteopathic Physicians/Preventive Medicine/Addiction Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (390, '84', 'Physician/Preventive Medicine', '2083B0002X', 'Allopathic & Osteopathic Physicians/Preventive Medicine/Obesity Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (391, '84', 'Physician/Preventive Medicine', '2083C0008X', 'Allopathic & Osteopathic Physicians/Preventive Medicine/Clinical Informatics');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (392, '85', 'Physician/Maxillofacial Surgery', '204E00000X', 'Allopathic & Osteopathic Physicians/Oral and Maxillofacial Surgery');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (393, '86', 'Physician/Neuropsychiatry', '2084A0401X', 'Allopathic & Osteopathic Physicians/ Psychiatry & Neurology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (394, '86', 'Physician/Neuropsychiatry', '2084P0802X', 'Allopathic & Osteopathic Physicians/ Psychiatry & Neurology Addiction Psychiatry');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (395, '86', 'Physician/Neuropsychiatry', '2084B0002X', 'Allopathic & Osteopathic Physicians/ Psychiatry & Neurology Bariatric Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (396, '86', 'Physician/Neuropsychiatry', '2084B0040X', 'Allopathic & Osteopathic Physicians/ Psychiatry & Neurology Behavioral Neurology & Neuropsychiatry');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (397, '86', 'Physician/Neuropsychiatry', '2084P0804X', 'Allopathic & Osteopathic Physicians/ Psychiatry & Neurology Child & Adolescent Psychiatry');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (398, '86', 'Physician/Neuropsychiatry', '2084N0600X', 'Allopathic & Osteopathic Physicians/ Psychiatry & Neurology Clinical Neurophysiology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (399, '86', 'Physician/Neuropsychiatry', '2084D0003X', 'Allopathic & Osteopathic Physicians/ Psychiatry & Neurology Diagnostic Neuroimaging');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (400, '86', 'Physician/Neuropsychiatry', '2084F0202X', 'Allopathic & Osteopathic Physicians/ Psychiatry & Neurology Forensic Psychiatry');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (401, '86', 'Physician/Neuropsychiatry', '2084P0805X', 'Allopathic & Osteopathic Physicians/ Psychiatry & Neurology Geriatric Psychiatry');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (402, '86', 'Physician/Neuropsychiatry', '2084H0002X', 'Allopathic & Osteopathic Physicians/ Psychiatry & Neurology Hospice & Palliative Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (403, '86', 'Physician/Neuropsychiatry', '2084P0005X', 'Allopathic & Osteopathic Physicians/ Psychiatry & Neurology Neurodevelopmental Disabilities');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (404, '86', 'Physician/Neuropsychiatry', '2084N0400X', 'Allopathic & Osteopathic Physicians/ Psychiatry & Neurology Neurology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (405, '86', 'Physician/Neuropsychiatry', '2084N0402X', 'Allopathic & Osteopathic Physicians/ Psychiatry & Neurology Neurology with Special Qualifications in Child Neurology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (406, '86', 'Physician/Neuropsychiatry', '2084N0008X', 'Allopathic & Osteopathic Physicians/ Psychiatry & Neurology Neuromuscular Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (407, '86', 'Physician/Neuropsychiatry', '2084P2900X', 'Allopathic & Osteopathic Physicians/ Psychiatry & Neurology Pain Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (408, '86', 'Physician/Neuropsychiatry', '2084P0800X', 'Allopathic & Osteopathic Physicians/ Psychiatry & Neurology Psychiatry');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (409, '86', 'Physician/Neuropsychiatry', '2084P0015X', 'Allopathic & Osteopathic Physicians/ Psychiatry & Neurology Psychosomatic Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (410, '86', 'Physician/Neuropsychiatry', '2084S0012X', 'Allopathic & Osteopathic Physicians/ Psychiatry & Neurology Sleep Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (411, '86', 'Physician/Neuropsychiatry', '2084S0010X', 'Allopathic & Osteopathic Physicians/ Psychiatry & Neurology Sports Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (412, '86', 'Physician/Neuropsychiatry', '2084V0102X', 'Allopathic & Osteopathic Physicians/ Psychiatry & Neurology Vascular Neurology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (413, '87[3]', 'All Other Suppliers', '332B00000X', 'Suppliers/Durable Medical Equipment & Medical Supplies');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (414, '88', 'Unknown Supplier/Provider Specialty[4]', NULL, NULL);
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (415, '89', 'Certified Clinical Nurse Specialist', '364S00000X', 'Physician Assistants & Advanced Practice Nursing Providers/Clinical Nurse Specialist');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (416, '89', 'Certified Clinical Nurse Specialist', '364SA2100X', 'Physician Assistants & Advanced Practice Nursing Providers/Clinical Nurse Specialist Acute Care');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (417, '89', 'Certified Clinical Nurse Specialist', '364SA2200X', 'Physician Assistants & Advanced Practice Nursing Providers/Clinical Nurse Specialist Adult Health');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (418, '89', 'Certified Clinical Nurse Specialist', '364SC2300X', 'Physician Assistants & Advanced Practice Nursing Providers/Clinical Nurse Specialist Chronic Care');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (419, '89', 'Certified Clinical Nurse Specialist', '364SC1501X', 'Physician Assistants & Advanced Practice Nursing Providers/Clinical Nurse Specialist Community Health/Public Health');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (420, '89', 'Certified Clinical Nurse Specialist', '364SC0200X', 'Physician Assistants & Advanced Practice Nursing Providers/Clinical Nurse Specialist Critical Care Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (421, '89', 'Certified Clinical Nurse Specialist', '364SE0003X', 'Physician Assistants & Advanced Practice Nursing Providers/Clinical Nurse Specialist Emergency');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (422, '89', 'Certified Clinical Nurse Specialist', '364SE1400X', 'Physician Assistants & Advanced Practice Nursing Providers/Clinical Nurse Specialist Ethics');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (423, '89', 'Certified Clinical Nurse Specialist', '364SF0001X', 'Physician Assistants & Advanced Practice Nursing Providers/Clinical Nurse Specialist Family Health');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (424, '89', 'Certified Clinical Nurse Specialist', '364SG0600X', 'Physician Assistants & Advanced Practice Nursing Providers/Clinical Nurse Specialist Gerontology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (425, '89', 'Certified Clinical Nurse Specialist', '364SH1100X', 'Physician Assistants & Advanced Practice Nursing Providers/Clinical Nurse Specialist Holistic');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (426, '89', 'Certified Clinical Nurse Specialist', '364SH0200X', 'Physician Assistants & Advanced Practice Nursing Providers/Clinical Nurse Specialist Home Health');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (427, '89', 'Certified Clinical Nurse Specialist', '364SI0800X', 'Physician Assistants & Advanced Practice Nursing Providers/Clinical Nurse Specialist Informatics');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (428, '89', 'Certified Clinical Nurse Specialist', '364SL0600X', 'Physician Assistants & Advanced Practice Nursing Providers/Clinical Nurse Specialist Long-term Care');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (429, '89', 'Certified Clinical Nurse Specialist', '364SM0705X', 'Physician Assistants & Advanced Practice Nursing Providers/Clinical Nurse Specialist Medical-Surgical');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (430, '89', 'Certified Clinical Nurse Specialist', '364SN0000X', 'Physician Assistants & Advanced Practice Nursing Providers/Clinical Nurse Specialist Neonatal');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (431, '89', 'Certified Clinical Nurse Specialist', '364SN0800X', 'Physician Assistants & Advanced Practice Nursing Providers/Clinical Nurse Specialist Neuroscience');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (432, '89', 'Certified Clinical Nurse Specialist', '364SX0106X', 'Physician Assistants & Advanced Practice Nursing Providers/Clinical Nurse Specialist Occupational Health');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (433, '89', 'Certified Clinical Nurse Specialist', '364SX0200X', 'Physician Assistants & Advanced Practice Nursing Providers/Clinical Nurse Specialist Oncology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (434, '89', 'Certified Clinical Nurse Specialist', '364SX0204X', 'Physician Assistants & Advanced Practice Nursing Providers/Clinical Nurse Specialist Oncology Pediatrics');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (435, '89', 'Certified Clinical Nurse Specialist', '364SP0200X', 'Physician Assistants & Advanced Practice Nursing Providers/Clinical Nurse Specialist Pediatrics');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (436, '89', 'Certified Clinical Nurse Specialist', '364SP1700X', 'Physician Assistants & Advanced Practice Nursing Providers/Clinical Nurse Specialist Perinatal');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (437, '89', 'Certified Clinical Nurse Specialist', '364SP2800X', 'Physician Assistants & Advanced Practice Nursing Providers/Clinical Nurse Specialist Perioperative');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (438, '89', 'Certified Clinical Nurse Specialist', '364SP0808X', 'Physician Assistants & Advanced Practice Nursing Providers/Clinical Nurse Specialist Psychiatric/Mental Health');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (439, '89', 'Certified Clinical Nurse Specialist', '364SP0809X', 'Physician Assistants & Advanced Practice Nursing Providers/Clinical Nurse Specialist Psychiatric/Mental Health Adult');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (440, '89', 'Certified Clinical Nurse Specialist', '364SP0807X', 'Physician Assistants & Advanced Practice Nursing Providers/Clinical Nurse Specialist Psychiatric/Mental Health Child & Adolescent');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (441, '89', 'Certified Clinical Nurse Specialist', '364SP0810X', 'Physician Assistants & Advanced Practice Nursing Providers/Clinical Nurse Specialist Psychiatric/Mental Health Child & Family');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (442, '89', 'Certified Clinical Nurse Specialist', '364SP0811X', 'Physician Assistants & Advanced Practice Nursing Providers/Clinical Nurse Specialist Psychiatric/Mental Health Chronically Ill');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (443, '89', 'Certified Clinical Nurse Specialist', '364SP0812X', 'Physician Assistants & Advanced Practice Nursing Providers/Clinical Nurse Specialist Psychiatric/Mental Health Community');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (444, '89', 'Certified Clinical Nurse Specialist', '364SP0813X', 'Physician Assistants & Advanced Practice Nursing Providers/Clinical Nurse Specialist Psychiatric/Mental Health Geropsychiatric');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (445, '89', 'Certified Clinical Nurse Specialist', '364SR0400X', 'Physician Assistants & Advanced Practice Nursing Providers/Clinical Nurse Specialist Rehabilitation');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (446, '89', 'Certified Clinical Nurse Specialist', '364SS0200X', 'Physician Assistants & Advanced Practice Nursing Providers/Clinical Nurse Specialist School');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (447, '89', 'Certified Clinical Nurse Specialist', '364ST0500X', 'Physician Assistants & Advanced Practice Nursing Providers/Clinical Nurse Specialist Transplantation');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (448, '89', 'Certified Clinical Nurse Specialist', '364SW0102X', 'Physician Assistants & Advanced Practice Nursing Providers/Clinical Nurse Specialist Womens Health');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (449, '90', 'Physician/Medical Oncology', '207RX0202X', 'Allopathic & Osteopathic Physicians/Internal Medicine Medical Oncology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (450, '91', 'Physician/Surgical Oncology', '2086X0206X', 'Allopathic & Osteopathic Physicians/Surgery Surgical Oncology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (451, '92', 'Physician/Radiation Oncology', '2085R0001X', 'Allopathic & Osteopathic Physicians/Radiology Radiation Oncology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (452, '93', 'Physician/Emergency Medicine', '207P00000X', 'Allopathic & Osteopathic Physicians/Emergency Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (453, '93', 'Physician/Emergency Medicine', '207PE0004X', 'Allopathic & Osteopathic Physicians/Emergency Medicine Emergency Medical Services');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (454, '93', 'Physician/Emergency Medicine', '207PH0002X', 'Allopathic & Osteopathic Physicians/Emergency Medicine Hospice and Palliative Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (455, '93', 'Physician/Emergency Medicine', '207PT0002X', 'Allopathic & Osteopathic Physicians/Emergency Medicine Medical Toxicology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (456, '93', 'Physician/Emergency Medicine', '207PP0204X', 'Allopathic & Osteopathic Physicians/Emergency Medicine Pediatric Emergency Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (457, '93', 'Physician/Emergency Medicine', '207PS0010X', 'Allopathic & Osteopathic Physicians/Emergency Medicine Sports Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (458, '93', 'Physician/Emergency Medicine', '207PE0005X', 'Allopathic & Osteopathic Physicians/Emergency Medicine Undersea and Hyperbaric Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (459, '94', 'Physician/Interventional Radiology', '2085R0204X', 'Allopathic & Osteopathic Physicians/Radiology Vascular and Interventional Radiology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (460, '94', 'Physician/Interventional Radiology', '2085H0002X', 'Hospice & Palliative Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (461, '95', 'Advance Diagnostic Imaging', NULL, NULL);
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (462, '96[5]', 'Optician', '156FX1800X', 'Eye & Vision Service Providers/Technician/Technologist Optician');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (463, '97', 'Physician Assistant', '363A00000X', 'Physician Assistants & Advanced Practice Nursing Providers/Physician Assistant');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (464, '97', 'Physician Assistant', '363AM0700X', 'Physician Assistants & Advanced Practice Nursing Providers/Physician Assistant Medical');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (465, '97', 'Physician Assistant', '363AS0400X', 'Physician Assistants & Advanced Practice Nursing Providers/Physician Assistant Surgical');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (466, '98', 'Physician/Gynecological Oncology', '207VX0201X', 'Allopathic & Osteopathic Physicians/Obstetrics & Gynecology Gynecologic Oncology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (467, '99', 'Physician/Undefined Physician type[6]', '208D00000X', 'Allopathic & Osteopathic Physicians/General Practice');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (468, 'A0[7]', 'Hospital-General', '282N00000X', 'Hospitals/General Acute Care Hospital');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (469, 'A0[7]', 'Hospital-Acute Care', '282N00000X', 'Hospitals/General Acute Care Hospital');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (470, 'A0[7]', 'Hospital-Childrens (PPS excluded)', '282NC2000X', 'Hospitals/General Acute Care Hospital Children');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (471, 'A0[7]', 'Hospital-Long-Term (PPS excluded)', '282E00000X', 'Hospitals/Long Term Care Hospital');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (472, 'A0[7]', 'Hospital-Psychiatric (PPS excluded)', '283Q00000X', 'Hospitals/Psychiatric Hospital');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (473, 'A0[7]', 'Hospital-Rehabilitation (PPS excluded)', '283X00000X', 'Hospitals/Rehabilitation Hospital');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (474, 'A0[7]', 'Hospital-Short-Term (General and Specialty)', '282N00000X', 'Hospitals/General Acute Care Hospital');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (475, 'A0[7]', 'Hospital Units', '273100000X', 'Hospital Units/Epilepsy Unit');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (476, 'A0[7]', 'Hospital Units', '276400000X', 'Hospital Units/Rehabilitation/Substance Use Disorder Unit');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (477, 'A0[7]', 'Hospitals', '281P00000X', 'Hospitals/Chronic Disease Hospital');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (478, 'A0[7]', 'Hospitals', '281PC2000X', 'Hospitals/Chronic Disease Hospital/Children');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (479, 'A0[7]', 'Hospitals', '282NR1301X', 'Hospitals/General Acute Care Hospital/Rural');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (480, 'A0[7]', 'Hospitals', '282NW0100X', 'Hospitals/General Acute Care Hospital/Women');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (481, 'A0[7]', 'Hospitals', '283XC2000X', 'Hospitals/General Acute Care Hospital/Children');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (482, 'A0[7]', 'Hospitals', '286500000X', 'Hospitals/Military Hospital');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (483, 'A0[7]', 'Hospitals', '2865M2000X', 'Hospitals/Military Hospital/Military General Acute Care Hospital');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (484, 'A0[7]', 'Hospitals', '2865X1600X', 'Hospitals/Military Hospital/Military General Acute Care Hospital Operational (Transportable)');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (485, 'A0[7]', 'Hospital-Swing Bed Approved', '275N00000X', 'Hospital Units/Medicare Defined Swing Bed Unit');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (486, 'A0[7]', 'Hospital-Psychiatric Unit', '273R00000X', 'Hospital Units/Psychiatric Unit');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (487, 'A0[7]', 'Hospital-Rehabilitation Unit', '273Y00000X', 'Hospital Units/Rehabilitation Unit');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (488, 'A0[7]', 'Hospital-Specialty Hospital (cardiac orthopedic surgical)', '284300000X', 'Hospitals/Special(ty) Hospital');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (489, 'A0[7]', 'Critical Access Hospital', '282NC0060X', 'Hospitals/General Acute Care Hospital Critical Access');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (490, 'A1[8]', 'Skilled Nursing Facility', '314000000X', 'Nursing and Custodial Care Facilities/Skilled Nursing Facility');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (491, 'A1[8]', 'Skilled Nursing Facility', '3140N1450X', 'Nursing & Custodial Care Facilities/Skilled Nursing Facility/Nursing Care Pediatric');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (492, 'A2[9]', 'Intermediate Care Nursing Facility', '332B00000X', 'Suppliers/Durable Medical Equipment & Medical Supplies');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (493, 'A2[9]', 'Intermediate Care Nursing Facility', '315P00000X', 'Nursing & Custodial Care Facilities/Intermediate Care Facility Mentally Retarded');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (494, 'A3[10]', 'Other Nursing Facility', '313M00000X', 'Nursing and Custodial Care Facilities/Nursing Facility');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (495, 'A4[11]', 'Home Health Agency', '251E00000X', 'Agencies/Home Health');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (496, 'A4[11]', 'Home Health Agency (Subunit)', '251E00000X', 'Agencies/Home Health');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (497, 'A5', 'Pharmacy ', '333600000X', 'Suppliers/Pharmacy');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (498, 'A5', 'Pharmacy ', '3336C0002X', 'Suppliers/Pharmacy Clinic Pharmacy');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (499, 'A5', 'Pharmacy ', '3336C0003X', 'Suppliers/Pharmacy Community/Retail Pharmacy');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (500, 'A5', 'Pharmacy ', '3336C0004X', 'Suppliers/Pharmacy Compounding Pharmacy');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (501, 'A5', 'Pharmacy ', '3336H0001X', 'Suppliers/Pharmacy Home Infusion Therapy Pharmacy');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (502, 'A5', 'Pharmacy ', '3336I0012X', 'Suppliers/Pharmacy Institutional Pharmacy');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (503, 'A5', 'Pharmacy ', '3336L0003X', 'Suppliers/Pharmacy Long-term Care Pharmacy');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (504, 'A5', 'Pharmacy ', '3336M0002X', 'Suppliers/Pharmacy Mail Order Pharmacy');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (505, 'A5', 'Pharmacy ', '3336M0003X', 'Suppliers/Pharmacy Managed Care Organization Pharmacy');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (506, 'A5', 'Pharmacy ', '3336N0007X', 'Suppliers/Pharmacy Nuclear Pharmacy');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (507, 'A5', 'Pharmacy ', '3336S0011X', 'Suppliers/Pharmacy Specialty Pharmacy');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (508, 'A5', 'Pharmacy ', '1835C0205X', 'Suppliers/Pharmacy Critical Care');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (509, 'A5', 'Pharmacy ', '1835P0200X', 'Suppliers/Pharmacy Pediatrics');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (510, 'A6', 'Medical Supply Company with Respiratory Therapist', '332B00000X', 'Suppliers/Durable Medical Equipment & Medical Supplies');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (511, 'A7', 'Department Store', '332B00000X', 'Suppliers/Durable Medical Equipment & Medical Supplies');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (512, 'A8', 'Grocery Store', '332B00000X', 'Suppliers/Durable Medical Equipment & Medical Supplies');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (513, 'A9[12]', 'Indian Health Service facility[13]', '332800000X', 'Suppliers/Indian Health Service/Tribal/Urban Indian Health (I/T/U) Pharmacy');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (514, 'B1', 'Oxygen supplier', '332BX2000X', 'Suppliers/Durable Medical Equipment & Medical Supplies Oxygen Equipment & Supplies');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (515, 'B2', 'Pedorthic personnel', '222Z00000X', 'Respiratory Developmental Rehabilitative and Restorative Service Providers/Orthotist');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (516, 'B2', 'Pedorthic personnel', '224P00000X', 'Respiratory Developmental Rehabilitative and Restorative Service Providers/Prosthetist');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (517, 'B3', 'Medical supply company with pedorthic personnel', '332B00000X', 'Suppliers/Durable Medical Equipment & Medical Supplies');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (518, 'B4[14]', 'Rehabilitation Agency', '261QR0400X', 'Ambulatory Health Care Facilities/Clinic/Center Rehabilitation');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (519, 'B4[14]', 'Organ Procurement Organization', '335U00000X', 'Suppliers/Organ Procurement Organization');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (520, 'B4[14]', 'Community Mental Health Center', '261QM0801X', 'Ambulatory Health Care Facilities/Clinic/Center Mental Health');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (521, 'B4[14]', 'Comprehensive Outpatient Rehabilitation Facility', '261QR0401X', 'Ambulatory Health Care Facilities/Clinic/Center Rehabilitation Comprehensive Outpatient Rehabilitation Facility (CORF)');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (522, 'B4[14]', 'End-Stage Renal Disease Facility', '261QE0700X', 'Ambulatory Health Care Facilities/End-Stage Renal Disease (ESRD) Treatment');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (523, 'B4[14]', 'Federally Qualified Health Center', '261QF0400X', 'Ambulatory Health Care Facilities/Federally Qualified Health Center (FQHC)');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (524, 'B4[14]', 'Hospice', '251G00000X', 'Agencies/Hospice Care Community Based');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (525, 'B4[14]', 'Histocompatibility Laboratory', '291U00000X', 'Laboratories/Clinical Medical Laboratory');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (526, 'B4[14]', NULL, '291900000X', 'Laboratories/Military Clinical Medical Laboratory');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (527, 'B4[14]', 'Outpatient Physical Therapy/Occupational Therapy/Speech Pathology Services ', '261QR0400X', 'Ambulatory Health Care Facilities/Clinic/Center Rehabilitation');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (528, 'B4[14]', 'Rehabilitation Agency', '315D00000X', 'Nursing & Custodial Care Facilities/Hospice Inpatient');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (529, 'B4[14]', 'Religious Non-Medical Health Care Institution', '282J00000X', 'Hospitals/Religious Non-medical Health Care Institution');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (530, 'B4[14]', 'Rural Health Clinic ', '261QR1300X', 'Ambulatory Health Care Facilities/Clinic/Center Rural Health');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (531, 'B5', 'Ocularist ', '156FX1700X', 'Eye and Vision Services Providers Technician/Technologist Ocularist');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (532, 'C0', 'Physician/Sleep Medicine', '207QS1201X', 'Allopathic & Osteopathic Physicians/Family Medicine Sleep Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (533, 'C0', 'Physician/Sleep Medicine', '207RS0012X', 'Allopathic & Osteopathic Physicians/Internal Medicine Sleep Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (534, 'C0', 'Physician/Sleep Medicine', '207YS0012X', 'Allopathic & Osteopathic Physicians/Otolaryngology/Sleep Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (535, 'C0', 'Physician/Sleep Medicine', '2080S0012X', 'Allopathic & Osteopathic Physicians/Pediatrics Sleep Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (536, 'C0', 'Physician/Sleep Medicine', '2084S0012X', 'Allopathic & Osteopathic Physicians/ Psychiatry & Neurology Sleep Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (537, 'C0', 'Physician/Sleep Medicine', '261QS1200X', 'Allopathic & Osteopathic Physicians/Ambulatory Health Care Facilities/Sleep Disorder Diagnostic');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (538, 'C3', 'Physician/Interventional Cardiology', '207RI0011X', 'Allopathic & Osteopathic Physicians/Internal Medicine Interventional Cardiology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (539, 'C5', 'Dentist', '122300000X', 'Allopathic & Osteopathic Physicians/Ophthalmology Dental Providers/Dentist');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (540, 'C5', 'Dentist', '1223G0001X', 'Allopathic & Osteopathic Physicians/General Practice');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (541, 'C6', 'Physician/Hospitalist', '208M00000X', 'Allopathic & Osteopathic Physicians/Hospitalist');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (542, 'C7', 'Physician/Advanced Heart Failure and Transplant Cardiology', '207RA0001X', 'Allopathic & Osteopathic Physicians/Advanced Heart Failure and Transplant Cardiology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (543, 'C8', 'Physician/Medical Toxicology', '207PT0002X', 'Allopathic & Osteopathic Physicians/Emergency Medicine Medical Toxicology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (544, 'C9', 'Hematopoietic Cell Transplantation and Cellular Therapy', NULL, NULL);
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (545, 'D1', 'Medicare Diabetes Preventive Program ', '174H00000X', 'Other Service Providers Health Educator');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (546, 'D3', 'Medical Genetics and Genomics ', '207SG0201X', 'Allopathic & Osteopathic Physicians/Clinical Genetics');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (547, 'D3', 'Medical Genetics and Genomics ', '207SG0202X', 'Allopathic & Osteopathic Physicians Medical Genetics/Clinical Biochemical Genetics');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (548, 'D3', 'Medical Genetics and Genomics ', '207SG0203X', 'Allopathic & Osteopathic Physicians/ Medical Genetics/Clinical Molecular Genetics');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (549, 'D3', 'Medical Genetics and Genomics ', '207SG0205X', 'Allopathic & Osteopathic Physicians/Medical Genetics/PhD Medical Genetics');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (550, 'D3', 'Medical Genetics and Genomics ', '207SM0001X', 'Allopathic & Osteopathic Physicians/Medical Genetics/Molecular Genetic Pathology');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (551, 'D4', 'Undersea and Hyperbaric Medicine ', '207PE0005X', 'Allopathic & Osteopathic Physicians/Undersea and Hyperbaric Medicine');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (552, 'D5', 'Opioid Treatment Program ', '261QR0405X', 'Ambulatory Health Care Facilities/Clinic/Center Rehabilitation');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (553, 'D6', 'Home Infusion Therapy Services', '3336H0001X', 'Suppliers Pharmacy Home Infusion Therapy Services');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (554, 'D7', 'Micrographic Dermatologic Surgery', '207ND0101X', 'Allopathic & Osteopathic Physicians Dermatology MOHS-Micrographic Surgery');
INSERT INTO public.provider_taxonomy_code (id, medicare_speciality_code, medicare_provider_or_supplier_type_description, code, type_classification_specialization) VALUES (555, 'D8', 'Adult Congenital Heart Disease ', '207RA0002X', 'Allopathic & Osteopathic Physicians Internal Medicine');


--
-- TOC entry 2915 (class 0 OID 90991)
-- Dependencies: 212
-- Data for Name: state; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.state (id, reference_code, name, type_code) VALUES (1, 'AK', 'ALASKA', 'S');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (2, 'AL', 'ALABAMA', 'S');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (3, 'AR', 'ARKANSAS', 'S');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (4, 'AS', 'AMERICAN SAMOA', 'T');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (5, 'AZ', 'ARIZONA', 'S');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (6, 'CA', 'CALIFORNIA', 'S');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (7, 'CO', 'COLORADO', 'S');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (8, 'CT', 'CONNECTICUT', 'S');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (9, 'DC', 'DISTRICT OF COLUMBIA', 'T');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (10, 'DE', 'DELAWARE', 'S');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (11, 'FL', 'FLORIDA', 'S');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (12, 'FM', 'MICRONESIA, FEDERATED STATES OF', 'T');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (13, 'GA', 'GEORGIA', 'S');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (14, 'GU', 'GUAM', 'T');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (15, 'HI', 'HAWAII', 'S');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (16, 'IA', 'IOWA', 'S');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (17, 'ID', 'IDAHO', 'S');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (18, 'IL', 'ILLINOIS', 'S');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (19, 'IN', 'INDIANA', 'S');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (20, 'KS', 'KANSAS', 'S');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (21, 'KY', 'KENTUCKY', 'S');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (22, 'LA', 'LOUISIANA', 'S');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (23, 'MA', 'MASSACHUSETTS', 'S');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (24, 'MD', 'MARYLAND', 'S');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (25, 'ME', 'MAINE', 'S');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (26, 'MH', 'MARSHALL ISLANDS', 'T');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (27, 'MI', 'MICHIGAN', 'S');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (28, 'MN', 'MINNESOTA', 'S');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (29, 'MO', 'MISSOURI', 'S');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (30, 'MP', 'MARIANA ISLANDS, NORTHERN', 'T');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (31, 'MS', 'MISSISSIPPI', 'S');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (32, 'MT', 'MONTANA', 'S');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (33, 'NC', 'NORTH CAROLINA', 'S');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (34, 'ND', 'NORTH DAKOTA', 'S');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (35, 'NE', 'NEBRASKA', 'S');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (36, 'NH', 'NEW HAMPSHIRE', 'S');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (37, 'NJ', 'NEW JERSEY', 'S');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (38, 'NM', 'NEW MEXICO', 'S');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (39, 'NV', 'NEVADA', 'S');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (40, 'NY', 'NEW YORK', 'S');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (41, 'OH', 'OHIO', 'S');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (42, 'OK', 'OKLAHOMA', 'S');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (43, 'OR', 'OREGON', 'S');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (44, 'PA', 'PENNSYLVANIA', 'S');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (45, 'PR', 'PUERTO RICO', 'T');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (46, 'PW', 'PALAU', 'T');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (47, 'RI', 'RHODE ISLAND', 'S');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (48, 'SC', 'SOUTH CAROLINA', 'S');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (49, 'SD', 'SOUTH DAKOTA', 'S');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (50, 'TN', 'TENNESSEE', 'S');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (51, 'TX', 'TEXAS', 'S');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (52, 'UT', 'UTAH', 'S');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (53, 'VA', 'VIRGINIA', 'S');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (54, 'VI', 'VIRGIN ISLANDS', 'T');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (55, 'VT', 'VERMONT', 'S');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (56, 'WA', 'WASHINGTON', 'S');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (57, 'WI', 'WISCONSIN', 'S');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (58, 'WV', 'WEST VIRGINIA', 'S');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (59, 'WY', 'WYOMING', 'S');
INSERT INTO public.state (id, reference_code, name, type_code) VALUES (60, 'ZZ', 'Foreign Country', 'T');


--
-- TOC entry 2916 (class 0 OID 90994)
-- Dependencies: 213
-- Data for Name: taxonomy; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2925 (class 0 OID 0)
-- Dependencies: 215
-- Name: address_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.address_id_seq', 1, true);


--
-- TOC entry 2926 (class 0 OID 0)
-- Dependencies: 214
-- Name: npi_information_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.npi_information_id_seq', 1, true);


--
-- TOC entry 2927 (class 0 OID 0)
-- Dependencies: 216
-- Name: taxonomy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.taxonomy_id_seq', 1, true);


--
-- TOC entry 2742 (class 2606 OID 90998)
-- Name: address address_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_pkey PRIMARY KEY (id);


--
-- TOC entry 2744 (class 2606 OID 91000)
-- Name: country country_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_pkey PRIMARY KEY (id);


--
-- TOC entry 2746 (class 2606 OID 91002)
-- Name: entity_type_code entity_type_code_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entity_type_code
    ADD CONSTRAINT entity_type_code_pkey PRIMARY KEY (id);


--
-- TOC entry 2748 (class 2606 OID 91004)
-- Name: gender_codes gender_codes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gender_codes
    ADD CONSTRAINT gender_codes_pkey PRIMARY KEY (id);


--
-- TOC entry 2750 (class 2606 OID 91006)
-- Name: group_taxonomy group_taxonomy_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_taxonomy
    ADD CONSTRAINT group_taxonomy_pkey PRIMARY KEY (id);


--
-- TOC entry 2752 (class 2606 OID 91008)
-- Name: identifier identifier_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identifier
    ADD CONSTRAINT identifier_pkey PRIMARY KEY (id);


--
-- TOC entry 2754 (class 2606 OID 91010)
-- Name: npi_information npi_information_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.npi_information
    ADD CONSTRAINT npi_information_pkey PRIMARY KEY (id);


--
-- TOC entry 2757 (class 2606 OID 91012)
-- Name: other_provider_identifier_issuer_code other_provider_identifier_issuer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.other_provider_identifier_issuer_code
    ADD CONSTRAINT other_provider_identifier_issuer_pkey PRIMARY KEY (id);


--
-- TOC entry 2759 (class 2606 OID 91014)
-- Name: primary_taxonomy primary_taxonomy_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.primary_taxonomy
    ADD CONSTRAINT primary_taxonomy_pkey PRIMARY KEY (id);


--
-- TOC entry 2761 (class 2606 OID 91016)
-- Name: provider_taxonomy_code provider_taxonomy_code_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provider_taxonomy_code
    ADD CONSTRAINT provider_taxonomy_code_pkey PRIMARY KEY (id);


--
-- TOC entry 2763 (class 2606 OID 91018)
-- Name: state state_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.state
    ADD CONSTRAINT state_pkey PRIMARY KEY (id);


--
-- TOC entry 2765 (class 2606 OID 91020)
-- Name: taxonomy taxonomy_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taxonomy
    ADD CONSTRAINT taxonomy_id_pk PRIMARY KEY (id);


--
-- TOC entry 2740 (class 1259 OID 142165)
-- Name: address_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX address_id_index ON public.address USING btree (id);


--
-- TOC entry 2755 (class 1259 OID 141981)
-- Name: npi_number_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX npi_number_index ON public.npi_information USING btree (number);


--
-- TOC entry 2766 (class 2606 OID 91021)
-- Name: address address_country_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_country_id_fk FOREIGN KEY (country_id) REFERENCES public.country(id);


--
-- TOC entry 2767 (class 2606 OID 91026)
-- Name: address address_state_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_state_id_fk FOREIGN KEY (state_id) REFERENCES public.state(id);


--
-- TOC entry 2768 (class 2606 OID 91031)
-- Name: address npi_address_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.address
    ADD CONSTRAINT npi_address_fk FOREIGN KEY (npi_information_id) REFERENCES public.npi_information(id) NOT VALID;


--
-- TOC entry 2772 (class 2606 OID 91036)
-- Name: npi_information npi_entity_type_code_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.npi_information
    ADD CONSTRAINT npi_entity_type_code_fk FOREIGN KEY (entity_type_code) REFERENCES public.entity_type_code(id) NOT VALID;


--
-- TOC entry 2773 (class 2606 OID 91041)
-- Name: npi_information npi_gender_code_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.npi_information
    ADD CONSTRAINT npi_gender_code_fk FOREIGN KEY (gender_code_id) REFERENCES public.gender_codes(id) NOT VALID;


--
-- TOC entry 2769 (class 2606 OID 91046)
-- Name: identifier npi_number_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identifier
    ADD CONSTRAINT npi_number_fk FOREIGN KEY (npi_information_id) REFERENCES public.npi_information(id);


--
-- TOC entry 2770 (class 2606 OID 91051)
-- Name: identifier other_provider_identifier_issuer_code_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identifier
    ADD CONSTRAINT other_provider_identifier_issuer_code_fk FOREIGN KEY (other_provider_identifier_issuer_code_id) REFERENCES public.other_provider_identifier_issuer_code(id);


--
-- TOC entry 2774 (class 2606 OID 91056)
-- Name: taxonomy primary_taxnomy_code_fk ; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taxonomy
    ADD CONSTRAINT "primary_taxnomy_code_fk " FOREIGN KEY (primary_taxonomy_id) REFERENCES public.primary_taxonomy(id) NOT VALID;


--
-- TOC entry 2775 (class 2606 OID 91061)
-- Name: taxonomy provider_taxonomy_code_codes_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taxonomy
    ADD CONSTRAINT provider_taxonomy_code_codes_fk FOREIGN KEY (taxonomy_code_id) REFERENCES public.provider_taxonomy_code(id) NOT VALID;


--
-- TOC entry 2771 (class 2606 OID 91066)
-- Name: identifier state_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identifier
    ADD CONSTRAINT state_id_fk FOREIGN KEY (state_id) REFERENCES public.state(id);


--
-- TOC entry 2776 (class 2606 OID 91071)
-- Name: taxonomy state_reference_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taxonomy
    ADD CONSTRAINT state_reference_id_fk FOREIGN KEY (state_id) REFERENCES public.state(id);


--
-- TOC entry 2777 (class 2606 OID 91076)
-- Name: taxonomy taxonomy_group_code_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taxonomy
    ADD CONSTRAINT taxonomy_group_code_fk FOREIGN KEY (taxanomy_group_id) REFERENCES public.group_taxonomy(id);


--
-- TOC entry 2778 (class 2606 OID 132635)
-- Name: taxonomy taxonomy_npi_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taxonomy
    ADD CONSTRAINT taxonomy_npi_id_fk FOREIGN KEY (npi_id) REFERENCES public.npi_information(id) NOT VALID;




