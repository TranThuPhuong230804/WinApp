use master
go
drop database KTPM
go
create database KTPM
go
use KTPM
go

create table HoSo
( Id int primary key identity
, Ten nvarchar(50)
, SDT varchar(50)
, Email varchar(50)
, Ext text
)
go
insert into HoSo values
	(N'Vũ Song Tùng', '0989154248', 'tung.vusong@hust.edu.vn', null),
	(N'Đào Lê Thu Thảo', '0989708960', 'thao.daolethu@hust.edu.vn', null)
go

create table Quyen
( Id int primary key identity
, Ten nvarchar(50)
, Ext varchar(50)
)
go
insert into Quyen values
	(N'Lập trình viên', 'Developer'),
	(N'Quản trị hệ thống', 'Admin'),
	(N'Cán bộ nghiệp vụ', 'Staff')
go

create table TaiKhoan
( Ten varchar(50) primary key
, MatKhau varchar(255)
, QuyenId int foreign key references Quyen(Id)
, HoSoId int foreign key references HoSo(Id)
)
go
insert into TaiKhoan values
	('dev', '1234', 1, null),
	('admin', '1234', 2, null),
	('0989154248', '1234', 3, 1),
	('0989708960', '1234', 3, 2)
go

create view ViewHoSo as
	SELECT HoSo.*, TaiKhoan.Ten as TenDangNhap, MatKhau, QuyenId, Quyen.Ten as Quyen FROM TaiKhoan
	INNER JOIN Quyen ON QuyenId = Quyen.Id
	INNER JOIN HoSo ON HoSoId = HoSo.Id
go

create table HanhChinh
( Id int primary key identity
, Ten nvarchar(50)
, TrucThuocId int foreign key references HanhChinh(Id)
)
go
insert into HanhChinh values
	( N'Tỉnh/Thành', NULL),
	( N'Quận/Huyện', 1),
	( N'Phường/Xã', 2),
	( N'Tổ/Thôn', 3)
go
create table TenHanhChinh
( 
	Ten nvarchar(50)
)
go
insert into TenHanhChinh values
	(N'Ấp'),
	(N'Bản'),
	(N'Buôn'),
	(N'Huyện'),
	(N'Làng'),
	(N'Phường'),
	(N'Quận'),
	(N'Sóc'),
	(N'Thành phố'),
	(N'Thị xã'),
	(N'Thị trấn'),
	(N'Thôn'),
	(N'Tỉnh'),
	(N'Tổ'),
	(N'Xã')
go
create table DonVi
( Id int primary key identity
, Ten nvarchar(50)
, HanhChinhId int foreign key references HanhChinh(Id)
, TenHanhChinh nvarchar(50)
, TrucThuocId int foreign key references DonVi(Id)
)
go

insert into DonVi values
	(N'Hà Nội', 1, N'Thành phố', NULL),
	(N'Hai Bà Trưng', 2, N'Quận', 1),
	(N'Bách Khoa', 3, N'Phường', 2),
	(N'Đồng Tâm', 3, N'Phường', 2),
	(N'Thái Bình', 1, N'Tỉnh', NULL),
	(N'Thái Thụy', 2, N'Huyện', 5),
	(N'Thụy Hải', 3, N'Xã', 6),
	(N'Thụy Xuân', 3, N'Xã', 6)
go

create view ViewDonVi as
	SELECT T.*, DonVi.Ten as TrucThuoc FROM
		(SELECT DonVi.*, HanhChinh.Ten as Cap FROM DonVi 
		inner join HanhChinh ON HanhChinhId = HanhChinh.Id) as T
	left join DonVi ON T.TrucThuocId = DonVi.Id
go

/*create table GiongCay
( Id int primary key identity
, Ten nvarchar(50)
, Nguon nvarchar(255)
)
go
insert into GiongCay values
	(N'Vải', N'Hải Dương'),
	(N'Nhãn', N'Hưng Yên'),
	(N'Mít', N'Nam Định'),
	(N'Dừa', N'Phú Xuyên')
go */

CREATE TABLE muc_dich
(
	id BIGINT IDENTITY PRIMARY KEY,
	ten NVARCHAR(255),
	parent_id BIGINT NULL FOREIGN KEY REFERENCES muc_dich(id),
)
GO
CREATE TABLE nguon_goc
(
	id BIGINT IDENTITY PRIMARY KEY,
	ten NVARCHAR(255),
)
GO
CREATE TABLE dieu_kien
(
	id BIGINT IDENTITY PRIMARY KEY,
	ten NVARCHAR(255),
)
GO
CREATE TABLE loai_cay
(
	id BIGINT IDENTITY PRIMARY KEY,
	ten NVARCHAR(255),
)
GO
CREATE TABLE tru_luong
(
	id BIGINT IDENTITY PRIMARY KEY,
	ten NVARCHAR(255),
)
GO
CREATE TABLE loai_chu
(
id BIGINT IDENTITY PRIMARY KEY,
ten nvarchar(255),
)
GO
CREATE TABLE chu
(
id BIGINT IDENTITY PRIMARY KEY,
ten NVARCHAR(255),
loai_chu_id BIGINT FOREIGN KEY REFERENCES loai_chu(id)
)
GO
CREATE TABLE rung
(
	id BIGINT IDENTITY PRIMARY KEY,
	ten NVARCHAR(255),
	toa_do NVARCHAR(255),
	dien_tich NVARCHAR(255),
	dvhc_id BIGINT FOREIGN KEY REFERENCES dvhc(id),
	nguon_goc_id BIGINT FOREIGN KEY REFERENCES nguon_goc(id),
	dieu_kien_id BIGINT FOREIGN KEY REFERENCES dieu_kien(id),
	loai_cay_id BIGINT FOREIGN KEY REFERENCES loai_cay(id),
	muc_dich_id BIGINT FOREIGN KEY REFERENCES muc_dich(id),
	chu_id BIGINT FOREIGN KEY REFERENCES chu(id),
	tru_luong_id BIGINT FOREIGN KEY REFERENCES tru_luong(id),

)
GO

INSERT INTO loai_cay VALUES (N'Rừng gỗ'), (N'Rừng tre nứa'), (N'Rừng hỗ giao gỗ và tre nứa'), (N'Rừng cau dừa')
GO

INSERT INTO nguon_goc VALUES (N'Rừng tự nhiên'), (N'Rừng trồng')
GO

INSERT INTO dieu_kien VALUES (N'Rừng trên núi đất'), (N'Rừng trên núi đá'), (N'Rừng trên đất ngập nước'), (N'Rừng trên cát')
GO

INSERT INTO tru_luong VALUES (N'Giàu'), (N'Trung bình'), (N'Nghèo')
GO

INSERT INTO muc_dich VALUES (N'Đặc dụng', null), (N'Sản xuất', null), (N'Phòng hộ', null)
GO

INSERT INTO loai_chu VALUES (N'Ban quản lý rừng đặc dụng'), (N'Ban quản lý rừng phòng hộ'), 
(N'Tổ chức kinh tế'), (N'Lực lượng vũ trang'), (N'Tổ chức KH&CN, ĐT, GD'), (N'Hộ gia đình cá nhân trong nước'),
(N'Cộng đồng dân cư'),(N'Doanh nghiệp đầu tư nước ngoài'), (N'UBND Xã')
GO

INSERT INTO chu values ('A', 1), ('B', 2), ('C',3), ('D', 4), ('E', 5)
GO
CREATE PROCEDURE insertMucDich @mucDich NVARCHAR(100), @loai NVARCHAR(100)
AS
INSERT INTO muc_dich VALUES (@mucDich, (SELECT id FROM muc_dich WHERE ten = @loai))
GO
EXEC insertMucdich @mucDich = N'Vườn quốc gia', @loai = N'Đặc dụng'
EXEC insertMucdich @mucDich = N'Khu dự trữ tự nhiên', @loai = N'Đặc dụng'
EXEC insertMucdich @mucDich = N'Khu bảo tồn loài - sinh cảnh', @loai = N'Đặc dụng'
EXEC insertMucdich @mucDich = N'Khu bảo vệ cảnh quan', @loai = N'Đặc dụng'
EXEC insertMucdich @mucDich = N'Vườn thực vật quốc gia và rừng giống quốc gia', @loai = N'Đặc dụng'
EXEC insertMucdich @mucDich = N'Vườn quốc gia', @loai = N'Đặc dụng'
EXEC insertMucdich @mucDich = N'Khu rừng nghiên cứu thực nghiệm khoa học', @loai = N'Đặc dụng'

EXEC insertMucdich @mucDich = N'Rừng tự nhiên', @loai = N'Sản xuất'
EXEC insertMucdich @mucDich = N'Rừng trồng', @loai = N'Sản xuất'

EXEC insertMucdich @mucDich = N'Rừng phòng hộ đầu nguồn', @loai = N'Phòng hộ'
EXEC insertMucdich @mucDich = N'Rừng bảo vệ nguồn nước của cộng đồng dân cư', @loai = N'Phòng hộ'
EXEC insertMucdich @mucDich = N'Rừng phòng hộ biên giới', @loai = N'Phòng hộ'
EXEC insertMucdich @mucDich = N'Rừng phòng hộ chắn gió, chắn cát bay', @loai = N'Phòng hộ'
EXEC insertMucdich @mucDich = N'Rừng phòng hộ chắn sóng, lấn biển', @loai = N'Phòng hộ'
GO

select * from ViewDonVi