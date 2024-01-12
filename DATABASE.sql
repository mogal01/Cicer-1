PGDMP     -                     |            Cicer1    12.17    12.17     (           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            )           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            *           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            +           1262    16393    Cicer1    DATABASE     �   CREATE DATABASE "Cicer1" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Italian_Italy.1252' LC_CTYPE = 'Italian_Italy.1252';
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
            public          postgres    false    203            �
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
       public            postgres    false    203           