create database oficina;
use oficina;
show tables;

-- criação da tabela clientes
create table clientes(
idclientes int auto_increment primary key, 
nome varchar(45) not null,
telefone varchar(9),
email varchar(40)
);

-- criação da tabela veículos
create table veiculos(
idveiculos int auto_increment primary key, 
cliente_id int not null,
marca varchar(45),
modelo varchar(45),
ano int,
foreign key (cliente_id) references clientes(idclientes)
);

-- criação da tabela serviços
create table servicos(
idservicos int auto_increment primary key, 
veiculo_id int not null,
data_serviço date,
valor float,
tipo_servico ENUM('Lavar', 'manutenção', 'revisão', 'troca de oleo') default 'manutenção',
foreign key (veiculo_id) references veiculos(idveiculos)
);


-- input dos dados nas tabelas criadas


insert into clientes(nome,telefone,email)
		values('Ronaldo',111222133,'ronaldo_3@teste.com'),
			  ('Carlos',251212243,'carlos_22@teste.com'),
              ('Mário',341212233,'mario_1@teste.com'),
              ('Renata',691122233,'renata_60@teste.com'),
              ('Gabriel',681522233,'gabriel_3@teste.com'),
              ('Lucas',471122233,'lucas_3@teste.com'),
              ('Samara',111224533,'samara_3@teste.com'),
              ('Laís',111222331,'lais_3@teste.com'),
              ('Arthur',119122233,'arthur_3@teste.com');
              

insert into veiculos(cliente_id,marca,modelo,ano)
		values(2,'Honda','Civic',2015),
			  (1,'Volkswagem','Golf',2020),
              (3,'Honda','Civic',2013),
              (4,'Honda','Civic',2009),
              (5,'Audi','A4',2015),
              (6,'Ford','Mustang',2022),
              (7,'Mercedes-Benz','C-class',2016),
              (8,'Nissan','Altima',2005),
              (9,'Toyota','camry',2001);
              
insert into servicos(veiculo_id,data_serviço,valor,tipo_servico)
		values(1,'2023-01-01',700,'revisão'),
              (1,'2023-01-01',30,'Lavar'),
              (1,'2023-01-10',30,'troca de oleo'),
              (2,'2023-02-10',300,'manutenção'),
			  (3,'2023-02-15',300,'manutenção'),
              (4,'2023-03-10',30,'troca de oleo'),
              (5,'2023-03-12',1500,'revisão'),
              (6,'2023-03-30',300,'manutenção'),
              (7,'2023-04-10',2200,'revisão'),
              (8,'2023-04-12',30,'troca de oleo'),
              (9,'2023-07-10',900,'revisão'),
              (2,'2023-08-19',50,'Lavar');
  
  

-- consultas sql para o projeto

-- visualizando as tabelas 

select*from clientes;
select*from veiculos;
select*from servicos;


-- Qual o faturamento total da oficina?

select sum(valor) as Faturamento_total from servicos;

-- Quais as marcas de carro dos clientes?

select distinct(marca) from clientes c
inner join veiculos v on c.idclientes = v.cliente_id;

-- Qual a marca de carro que mais aparece no seu estabelecimento?

select marca, count(*) as quantidade from veiculos
group by marca
order by quantidade desc
limit 1;

-- Quem fez o serviço mais caro do seu estabelicimento, diga também qual foi o valor.

select nome, valor from clientes c 
inner join servicos s on c.idclientes = s.veiculo_id
order by valor desc
limit 1;

-- Qual o tipo de serviço que mais foi realizado no estabelecimento

select tipo_servico, count(*) as total from servicos
group by tipo_servico
order by total desc
limit 1;

-- Qual mês ocorreu mais serviços?

select date_format(data_serviço, '%Y-%m') as mes, count(*) as total from servicos
group by mes
order by total desc
LIMIT 1;

-- Qual o cliente que mais fez compras na oficina?

select c.nome, count(*) as total_servicos from clientes c
JOIN veiculos v on c.idclientes = v.cliente_id
JOIN servicos s on v.idveiculos = s.veiculo_id
group by c.idclientes
order by total_servicos desc
LIMIT 1;

-- . --