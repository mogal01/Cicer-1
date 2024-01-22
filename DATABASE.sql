PGDMP                          |            Cicer1    12.17    12.17      3           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            4           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            5           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            6           1262    16393    Cicer1    DATABASE     �   CREATE DATABASE "Cicer1" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Italian_Italy.1252' LC_CTYPE = 'Italian_Italy.1252';
    DROP DATABASE "Cicer1";
                postgres    false            �            1259    24643    destinazione    TABLE     �   CREATE TABLE public.destinazione (
    id smallint NOT NULL,
    nome character varying(100) NOT NULL,
    stato character varying(50) NOT NULL,
    tipo character varying(50) NOT NULL,
    edificio smallint NOT NULL
);
     DROP TABLE public.destinazione;
       public         heap    postgres    false            �            1259    24641    destinazione_id_seq    SEQUENCE     �   ALTER TABLE public.destinazione ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.destinazione_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    209            �            1259    32779    edificio    TABLE     W   CREATE TABLE public.edificio (
    id smallint NOT NULL,
    nome character varying
);
    DROP TABLE public.edificio;
       public         heap    postgres    false            �            1259    32777    edificio_id_seq    SEQUENCE     �   ALTER TABLE public.edificio ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.edificio_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    211            �            1259    24636    evento    TABLE     c  CREATE TABLE public.evento (
    id smallint NOT NULL,
    nome character varying(50) NOT NULL,
    data_ora_inizio timestamp without time zone NOT NULL,
    data_ora_fine timestamp without time zone NOT NULL,
    tipo character varying(50) NOT NULL,
    destinazione smallint NOT NULL,
    utente smallint NOT NULL,
    responsabile smallint NOT NULL
);
    DROP TABLE public.evento;
       public         heap    postgres    false            �            1259    24634    evento_id_seq    SEQUENCE     �   ALTER TABLE public.evento ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.evento_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    207            �            1259    24629    responsabile    TABLE       CREATE TABLE public.responsabile (
    id smallint NOT NULL,
    nome character varying(50) NOT NULL,
    cognome character varying(50) NOT NULL,
    orario_inizio_ricevimento time without time zone,
    orario_fine_ricevimento time without time zone,
    destinazione smallint
);
     DROP TABLE public.responsabile;
       public         heap    postgres    false            �            1259    24627    responsabile_id_seq    SEQUENCE     �   ALTER TABLE public.responsabile ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.responsabile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    205            �            1259    32787    token    TABLE     f   CREATE TABLE public.token (
    utente smallint NOT NULL,
    token character varying(40) NOT NULL
);
    DROP TABLE public.token;
       public         heap    postgres    false            �            1259    24621    utente    TABLE     
  CREATE TABLE public.utente (
    id smallint NOT NULL,
    nome character varying(50) NOT NULL,
    cognome character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    password character varying(50) NOT NULL,
    permessi character varying(50)
);
    DROP TABLE public.utente;
       public         heap    postgres    false            �            1259    24619    utente_id_seq    SEQUENCE     �   ALTER TABLE public.utente ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.utente_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    203            -          0    24643    destinazione 
   TABLE DATA           G   COPY public.destinazione (id, nome, stato, tipo, edificio) FROM stdin;
    public          postgres    false    209   �#       /          0    32779    edificio 
   TABLE DATA           ,   COPY public.edificio (id, nome) FROM stdin;
    public          postgres    false    211   T&       +          0    24636    evento 
   TABLE DATA           t   COPY public.evento (id, nome, data_ora_inizio, data_ora_fine, tipo, destinazione, utente, responsabile) FROM stdin;
    public          postgres    false    207   &       )          0    24629    responsabile 
   TABLE DATA           {   COPY public.responsabile (id, nome, cognome, orario_inizio_ricevimento, orario_fine_ricevimento, destinazione) FROM stdin;
    public          postgres    false    205   j'       0          0    32787    token 
   TABLE DATA           .   COPY public.token (utente, token) FROM stdin;
    public          postgres    false    212   �)       '          0    24621    utente 
   TABLE DATA           N   COPY public.utente (id, nome, cognome, email, password, permessi) FROM stdin;
    public          postgres    false    203   u*       7           0    0    destinazione_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.destinazione_id_seq', 62, true);
          public          postgres    false    208            8           0    0    edificio_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.edificio_id_seq', 3, true);
          public          postgres    false    210            9           0    0    evento_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.evento_id_seq', 45, true);
          public          postgres    false    206            :           0    0    responsabile_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.responsabile_id_seq', 47, true);
          public          postgres    false    204            ;           0    0    utente_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.utente_id_seq', 40, true);
          public          postgres    false    202            �
           2606    32791    token Token_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.token
    ADD CONSTRAINT "Token_pkey" PRIMARY KEY (token);
 <   ALTER TABLE ONLY public.token DROP CONSTRAINT "Token_pkey";
       public            postgres    false    212            �
           2606    24647    destinazione destinazione_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.destinazione
    ADD CONSTRAINT destinazione_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.destinazione DROP CONSTRAINT destinazione_pkey;
       public            postgres    false    209            �
           2606    32786    edificio edificio_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.edificio
    ADD CONSTRAINT edificio_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.edificio DROP CONSTRAINT edificio_pkey;
       public            postgres    false    211            �
           2606    24640    evento evento_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.evento
    ADD CONSTRAINT evento_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.evento DROP CONSTRAINT evento_pkey;
       public            postgres    false    207            �
           2606    24633    responsabile responsabile_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.responsabile
    ADD CONSTRAINT responsabile_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.responsabile DROP CONSTRAINT responsabile_pkey;
       public            postgres    false    205            �
           2606    24625    utente utente_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.utente
    ADD CONSTRAINT utente_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.utente DROP CONSTRAINT utente_pkey;
       public            postgres    false    203            -   �  x��V�r�0]_�B�nJ�$��R�6�`�Mv�GI4c�ԏM���4���v�u�}I�9�0��"�$���N�I�=j݃XP�>ĒZ ���%����xI�s�35T���s�?�ČKȈ�� �s��|�QNr|ȼ9۫<9�<%)d�4,!#�A`1k�V ��I���!v��~wL���D��_��ڤ�:�y��t��K5�/Ai8��@m8)�XC�BN� �TB��TB���!=0
�� L*g҇����!��#�8+��!�m����܄�p(Ȋ���>5���6�Ѳ�v��,lίC��lS����U� '��p��	Y����\1�u�Q�jZk�7���,um�g��u����!;��l�j��������2}�6؈~�]yV�yBۖ��-�ҙ��ew��$��؜�/�<N�5��Q�a�wk�/�i�O��̣�Xٸ�ħ�}�>�G��P|�M␿�+��u��l��?��&I�0ݥ�$L]qx���� $�����Ya��i�~�&�q�MU}Q�:�wN��(�	CYT Sé~���T���S-7��-Z�Ue}ӎ��1�e��t׍9u�k�Ԛ���e� o�����s�Ix!L��h^�(�̇��Ԭ�>�M�\S��)Y�#�/��[�CL�0�τCT��֦6�x���6�eEy�*&�<)����p7��~Y�v�      /      x�3�t3�2�t3�2�t����� ��      +   �   x���Mn� F��)����	���&�F���:�E�A�4����Ov#�]�xz�A+��dI��u�m�I#�
�"�ج�fD���~�ୢ�xԨC]�a�ˁ��i6/�j`T��~�dS������������/�)��pL��e0�w�T(��i�Y�\?z]��W�d�c�~"Sk�G�f�y	�d;񙒇[�������b5fw������6�X���      )   .  x�USˎ�0<7_���Vy {�����9���1&ӒcG��_�m^v�,W����\���h��Ԟ�%�څ��ac�<�� _� ��&P[���*�:O�"����;a����/��Rk�7�c(S���Pk���N�D�PR�Rf+>�ثȡ�'+o��"(�L#�7�[r"R%���
o�Y��`����Yv)��hYݒ�]0&"X|s�2ڎؓ߮7�|�x
+R����JZ;dx�-:G��D:���ᒗ/�p �4��I�2���7a�7�*��,`s!��Fۢ�=ʒ�lK�Ů�Q
U!7Ak�WJ�1Q]ч�6��16�����L,v�
yS�ZN
�m@����� �-���}�`�ۡ=K�O'ظ=�n�*�1b�&�Q���d�K���XqHN<BVsj����&�WyUl��t���8RE�4o �'q=�A��F��l�!�G������%��<��q�Jݳ�B���������n?i�����P����x9���Z;��'4�G���e���A/���ტx�IH7�o8�������|_?G����M�      0   �   x�%��1߹^�0c�L�$J�q.Ҋ�h�m�x�ȶ3xRϦ�H	�Yl����\��10x��
�N�t�Ď�-�؀+���s$JW����f,������UH�c���T	����	��-�I���*�8#LWj\e�����z��}C�hg�/�Qc��	��y]���Ae      '   �   x�e��N�0�g�)x���?I[˕������K��KGi����@(�c�V*.Ӷ�@�"`�}*^���K��ܻ5EL�ja��Npo��@�EgΓ=V���4�\�!�C�5׍6mޮ��l$�j��=��gXD��6W�o�I.#N�=
I�>�O��4���#�j���$J��-�~��X��T�;�t������,�+~^�ݕ>�ӑ�R(�� �yY     