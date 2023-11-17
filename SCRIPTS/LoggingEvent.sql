CREATE TABLE LoggingEvent
(
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    EventDateTime DATETIME NOT NULL DEFAULT GETDATE(),
    EventType NVARCHAR(50) NOT NULL,
    EventMessage NVARCHAR(MAX) NOT NULL
);