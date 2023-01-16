create table messages(
    id SERIAL PRIMARY KEY,
    content TEXT NOT NULL
);

create table threads(
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    thread_msgs TEXT[]
);

