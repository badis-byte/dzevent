PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE events (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      description TEXT NOT NULL,
      startDatetime TEXT NOT NULL,
      endDatetime TEXT NOT NULL,
      imageUrl TEXT,
      location TEXT,
      createdAt TEXT NOT NULL,
      association_id INTEGER,
      category TEXT
    );
INSERT INTO events VALUES(1,'event 1','this is the first event','2025-12-02 15:00:00','2025-12-02 15:00:00','assets/event_feed/image1.png','algiers','2025-12-02 15:00:00',0,'party');
INSERT INTO events VALUES(2,'event 2','this is the second event','2025-12-02 15:00:00','2025-12-02 15:00:00','assets/event_feed/image2.png','algiers','2025-12-02 15:00:00',0,'workshop');
INSERT INTO sqlite_sequence VALUES('events',2);
COMMIT;
