/*create database ge_hackathon;*/

CREATE TABLE hospital (
    hospital_id INT AUTO_INCREMENT PRIMARY KEY,
    hospital_name VARCHAR(100),
    type VARCHAR(50),
    managed_by VARCHAR(50),
    location VARCHAR(100),
    email VARCHAR(100),
    phone_number VARCHAR(15)
);

CREATE TABLE machine_info(
	hospital_id int,
    asset_id VARCHAR(50) PRIMARY KEY,
    machine_name VARCHAR(50),
    FOREIGN KEY (hospital_id) REFERENCES hospital(hospital_id)
    );
    
    
CREATE TABLE error_codes_solutions (
    error_id INT AUTO_INCREMENT PRIMARY KEY,
    error_code VARCHAR(20),
    error_description TEXT,
    solution_details TEXT,
    fix_by ENUM('Customer', 'Service Executive')
);

CREATE TABLE problem_history_db (
    problem_id INT AUTO_INCREMENT PRIMARY KEY,
    hospital_id INT,
    asset_id VARCHAR(50),
    error_id INT,
    problem_description TEXT,
    report_date DATE,
    solution TEXT,
    fix_by ENUM('Customer', 'Service Executive'),
    FOREIGN KEY (hospital_id) REFERENCES hospital(hospital_id),
    FOREIGN KEY (error_id) REFERENCES error_codes_solutions(error_id),
    FOREIGN KEY(asset_id) REFERENCES machine_info(asset_id)
);

INSERT INTO hospital (hospital_name, type, managed_by, location, email, phone_number)
VALUES
    ('Acharya Shree Bhikshu Hospital', 'Public', 'Government of NCT of Delhi', 'Moti Nagar', 'acharya@example.com', '123-456-7890'),
    ('Dharamshila Narayana Superspeciality Hospital', 'Private', 'Narayana Health', 'Vasundhara Enclave', 'dharamshila@example.com', '987-654-3210'),
    ('Dr. Ram Manohar Lohia Hospital', 'Public', 'Government of India', 'Connaught Place', 'ramlohia@example.com', '555-123-4567'),
    ('Fortis Escorts Heart Institute', 'Private', 'Fortis Healthcare', 'Okhla', 'fortis@example.com', '111-222-3333'),
    ('Fortis Flt. Lt. Rajan Dhall Hospital', 'Private', 'Fortis Healthcare', 'Vasant Kunj', 'fortisrajandhall@example.com', '444-555-6666'),
    ('Fortis Hospital', 'Private', 'Fortis Healthcare', 'Shalimar Bagh', 'fortisshalimar@example.com', '777-888-9999'),
    ('Fortis La Femme', 'Private', 'Fortis Healthcare', 'Greater Kailash', 'fortisfemme@example.com', '999-888-7777'),
    ('Govind Ballabh Pant Hospital', 'Public', 'Government of NCT of Delhi', 'Jawaharlal Nehru Marg', 'govindpant@example.com', '222-333-4444'),
    ('Guru Teg Bahadur Hospital', 'Public', 'Government of NCT of Delhi', 'Dilshad Garden', 'gurutegbahadur@example.com', '666-555-4444'),
    ('Holy Family Hospital', 'Private', 'Roman Catholic Archdiocese of Delhi', 'Okhla', 'holyfamily@example.com', '444-333-2222'),
    ('Indraprastha Apollo Hospital', 'Private', 'Apollo Hospitals', 'Jasola Vihar', 'apollojasola@example.com', '555-666-7777'),
    ('Lok Nayak Hospital', 'Public', 'Government of NCT of Delhi', 'Jawaharlal Nehru Marg', 'lokayak@example.com', '666-777-8888'),
    ('Maharaja Agrasen Hospital', 'Private', 'Maharaja Agrasen Hospital Charitable Trust', 'Punjabi Bagh', 'maharajaagrasen@example.com', '111-111-1111'),
    ('Max Med Centre & Institute of Cancer Care', 'Private', 'Max Healthcare', 'Lajpat Nagar', 'maxmed@example.com', '222-222-2222'),
    ('Max Multi Speciality Centre', 'Private', 'Max Healthcare', 'Panchsheel Park', 'maxmultispecial@example.com', '333-333-3333'),
    ('Max Smart Super Speciality Hospital', 'Private', 'Max Healthcare', 'Saket', 'maxsmartsuper@example.com', '444-444-4444'),
    ('Max Super Speciality Hospital', 'Private', 'Max Healthcare', 'Patparganj, Saket & Shalimar Bagh', 'maxsuperspecial@example.com', '555-555-5555'),
    ('National Heart Institute', 'Private', NULL, 'East of Kailash', 'nationalheart@example.com', '777-777-7777'),
    ('Park Hospital', 'Private', 'Park Group of Hospitals', 'Chaukhandi', 'parkhospital@example.com', '888-888-8888'),
    ('Rajiv Gandhi Cancer Institute and Research Centre', 'Private', 'Indraprastha Cancer Society and Research Centre', 'Niti Bagh & Rohini', 'rajivgandhicancer@example.com', '999-999-9999'),
    ('Rajiv Gandhi Super Specialty Hospital', 'Public', 'Government of NCT of Delhi', 'Dilshad Garden', 'rajivsuper@example.com', '333-666-9999'),
    ('Safdarjung Hospital', 'Public', 'Government of India', 'Ansari Nagar West', 'safdarjung@example.com', '222-777-4444'),
    ('Sanjeevan Hospital', 'Private', NULL, 'Daryaganj', 'sanjeevan@example.com', '666-333-9999'),
    ('Sir Ganga Ram Hospital', 'Private', NULL, 'Rajinder Nagar', 'gangaram@example.com', '444-777-8888'),
    ('St. Stephen\'s Hospital', 'Private', NULL, 'Tis Hazari', 'ststephens@example.com', '111-555-9999');

INSERT INTO machine_info(hospital_id,asset_id,machine_name)
VALUES
	(1,'MSN001','CT SCANNER'),
	(1,'MSN002','CT SCANNER'),
	(2,'MSN003','MRI MACHINE'),
	(3,'MSN004','PET SCANNER'),
	(4,'MSN005','PET SCANNER'),
	(5,'MSN006','CT SCANNER'),
	(4,'MSN007','CT SCANNER'),
	(21,'MSN008','PET SCANNER'),
	(18,'MSN009','PET SCANNER'),
	(10,'MSN010','CT SCANNER'),
	(12,'MSN011','MRI MACHINE'),
	(14,'MSN012','MRI MACHINE'),
	(25,'MSN013','CT SCANNER'),
	(25,'MSN014','MRI MACHINE'),
	(6,'MSN015','CT SCANNER'),
	(7,'MSN016','MRI MACHINE'),
	(8,'MSN017','MRI MACHINE'),
	(11,'MSN018','MRI MACHINE'),
	(17,'MSN019','CT SCANNER'),
	(23,'MSN020','CT SCANNER');
    
INSERT INTO error_codes_solutions (error_code, error_description, solution_details,fix_by)
VALUES
    ('E001', 'CT Scanner DVD Writer Not Working', '1. Check for Physical Connections and Power Supply 2.Inspect the DVD Media 3.Software and Driver Verification 4.Check for Error Messages 5.Test with Different Software and Hardware 6.Consult the Manufacturer or Technical Support','Customer'),
	('E002', 'MRI Machine Magnetic Field Instability', '1.	Verify proper power supply.2.	Inspect the magnet cooling system.3.	Check for nearby ferrous objects.4.	Calibrate magnetic field settings.5.	Monitor stability during scans.','Customer'),
	('E003', 'X-Ray Machine Image Artifacts', '1.	Check for loose cables.2.	Inspect X-ray detector for debris.3.	Calibrate image processing.4.	Test with different exposure settings.5.	Schedule regular equipment maintenance.','Customer'),
	('E004', 'Ultrasound Machine No Image Display', '1.	Confirm power and connections.2.	Check transducer connections.3.	Adjust imaging settings.4.	Reboot the machine.5.	Replace the transducer if needed.','Service Executive'),
	('E005', 'EMR System Software Crash', '1.	Save and back up data.2.	Restart the EMR software.3.	Check for software updates.4.	Investigate system logs for errors.5.	Contact IT support for assistance.','Customer'),
	('E006', 'PACS System Data Loss', '1.	Stop data entry immediately.2.	Identify the cause of data loss.3.	Attempt data recovery.4.	Investigate backup restoration.5.	Implement data loss prevention measures.','Service Executive'),
	('E007', 'Blood Pressure Monitor Inaccurate Readings', '1.	Verify cuff placement2.	Check cuff size and condition.3.	Inspect tubing for leaks.4.	Calibrate the monitor.5.	Educate users on proper technique.','Customer'),
	('E008', 'Ventilator Machine Alarm Malfunction', '1.	Review alarm settings.2.	Check sensor connections.3.	Test alarm functionality.4.	Update alarm thresholds if needed.5.	Ensure adequate ventilator maintenance.','Service Executive'),
	('E009', 'Anesthesia Machine Gas Leak', '1.	Power off the machine.2.	Inspect gas hoses for damage.3.	Tighten loose connections.4.	Test for leaks with a gas analyzer.5.	Conduct safety checks before use.','Customer'),
	('E010', 'Lab Analyzer Instrument Calibration Issue', '1.	Access calibration settings.2.	Follow calibration procedure.3.	Verify instrument accuracy.4.	Document calibration details.5.	Schedule regular recalibrations.','Service Executive'),
	('E011', 'Patient Monitor Display Flickering', '1.	Check the power connection.2.	Inspect the display cable for damage.3.	Re-seat or replace the display cable.4.	Update display drivers if applicable.5.	Test the monitor with a different device.','Service Executive'),
	('E012', 'Surgical Robot Arm Jitter', '1.	Examine the robot arm for obstructions.2.	Lubricate moving parts if needed.3.	Ensure power and connections are secure.4.	Calibrate the robot arms sensors.5.	Test arm movement and adjust settings.','Customer'),
	('E013', 'Dialysis Machine Pump Failure', '1.	Power off the machine.2.	Inspect and clean the pump.3.	Check tubing for blockages.4.	Replace worn-out pump components.5.	Restart the machine and monitor operation.','Service Executive'),
	('E014', 'Medical Cart Computer Freezing', '1.	Close unnecessary applications.2.	Check for malware or viruses.3.	Increase RAM or clear memory.4.	Update software and drivers.5.	Monitor for overheating and clean vents.','Customer'),
	('E015', 'Hospital Network Connectivity Issues', '1.	Check network cables and connections.2.	Restart routers and switches.3.	Reconfigure network settings if needed.4.	Test connectivity with other devices.5.	Contact IT support for advanced troubleshooting.','Customer'),
	('E016', 'Endoscopy System Image Quality Degradation', '1.	Clean the camera lens.2.	Inspect and clean the light source.3.	Check cable connections.4.	Calibrate image settings.5.	Schedule regular system maintenance.','Customer'),
	('E017', 'Patient Bed Actuator Malfunction', '1.	Check for loose or damaged parts.2.	Lubricate moving components.3.	Test bed adjustments.4.	Replace faulty actuators.5.	Implement routine maintenance checks.','Customer'),
	('E018', 'EKG Machine Electrode Connection Problem', '1.	Verify electrode placement.2.	Reattach loose electrodes securely.3.	Check for damaged cables.4.	Replace worn-out electrodes.5.	Educate staff on proper placement.','Customer'),
	('E019', 'Radiation Therapy Machine Calibration Error', '1.	Access calibration settings.2.	Follow calibration procedure.3.	Verify radiation accuracy.4.	Document calibration details.5.	Schedule regular recalibrations.','Customer'),
	('E020', 'Syringe Pump Battery Failure', '1.Power off the pump.2.Replace the worn-out battery.3.Ensure proper battery placement.4.Power on the pump and test.5.Keep spare batteries on hand.','Customer');
    
INSERT INTO problem_history_db(hospital_id,asset_id,error_id,problem_description,solution,fix_by,report_date)
VALUES
(1,'MSN001',1, 'CT Scanner DVD Writer Not Working', 'Replaced malfunctioning DVD writer with a new one.','Customer','2019-08-02'),
(5,'MSN006',1, 'CT Scanner DVD Writer Not Working', 'Replaced malfunctioning DVD writer with a new one.','Customer','2021-05-02'),
(3,'MSN004',10, 'Lab Analyzer Instrument Calibration Issue', 'Calibrated the lab analyzer for accurate test results.','Service Executive','2023-09-01'),
(18,'MSN009',9, 'Anesthesia Machine Gas Leak', 'Fixed the gas leak by replacing damaged components.','Customer','2022-03-11'),
(8,'MSN017',2, 'MRI Machine Magnetic Field Instability', 'Calibrated the MRI machine to stabilize the magnetic field.','Customer','2023-05-21'),
(2,'MSN003',13, 'Dialysis Machine Pump Failure', 'Replaced the faulty pump to restore normal operation.','Service Executive','2015-11-06');

select * from hospital;
select * from machine_info;
select * from error_codes_solutions;
select * from problem_history_db;
