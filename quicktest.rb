p = Publication.find(1)
r = Reminder.find(1)
r.send_reminder(p)
