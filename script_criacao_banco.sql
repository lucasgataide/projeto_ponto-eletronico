create or replace function trigger_set_timestamp()
returns trigger as $$
begin
	new.Marcacao_Data = now();
	return new;
end;
$$ language plpgsql;



create table if not exists pessoas(
	Id_Pessoa SERIAL primary key,
	Nome VARCHAR (50) not null,
	Senha INT not null,
	Flag_Ativo Bool not null,
	Tipo_Funcionario INT,
	RF_Cartao INT
);


create table if not exists Fotos(
	Id_Foto SERIAL primary key,
	URL text 
);


create table if not exists Controle(
	Id_Controle SERIAL primary key,
	Id_Pessoa INT not null,
	Marcacao_Data TIMESTAMP not null default now(),
    Tipo_Marcacao int,
    Tipo_Marcacao_Desc varchar (50),
    Id_Foto int,
    foreign key (Id_Pessoa) references Pessoas (Id_Pessoa),
	foreign key (Id_Foto) references Fotos (Id_Foto)
);

create trigger set_timestamp
before insert on Controle
for each row
execute procedure trigger_set_timestamp();


grant all on pessoas,fotos,controle to pontofinal;

