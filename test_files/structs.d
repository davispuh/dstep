extern (C):

struct Foo
{
    int a;
}

struct Bar
{
    int x;
}

extern __gshared Bar b;

extern __gshared Foo c;

struct A
{
    struct B
    {
        int x;
    }

    B b;
}

struct C
{
    struct _Anonymous_0
    {
        int x;
        int y;
    }
}

struct D
{
    int x;
    int y;
}

struct E
{
}

struct Nested
{
    C field;
}

struct F;
