/**
 * Copyright: Copyright (c) 2016 Wojciech Szęszoł. All rights reserved.
 * Authors: Wojciech Szęszoł
 * Version: Initial created: May 26, 2016
 * License: $(LINK2 http://www.boost.org/LICENSE_1_0.txt, Boost Software License 1.0)
 */

module dstep.translator.TypedefIndex;

import clang.c.Index;
import clang.Cursor;
import clang.TranslationUnit;

class TypedefIndex
{
    private Cursor[Cursor] typedefs;

    this(TranslationUnit translUnit)
    {
        bool[Cursor] visited;

        auto file = translUnit.file;

        foreach (cursor; translUnit.cursor.all)
        {
            if (cursor.file == file)
            {
                visited[cursor] = true;
                inspect(cursor, visited);
            }
        }
    }

    private void inspect(in Cursor cursor, bool[Cursor] visited)
    {
        if (cursor.kind == CXCursorKind.CXCursor_TypedefDecl)
        {
            size_t count = 0;

            foreach (child; cursor.all)
            {
                assert(count == 0);
                typedefs[child] = cursor;
                ++count;
            }
        }
        else if ((cursor in visited) is null)
        {
            foreach (child; cursor.all)
            {
                visited[cursor] = true;
                inspect(cursor, visited);
            }
        }
    }

    bool hasTypedefParent(in Cursor cursor)
    {
        return (cursor in typedefs) !is null;
    }
}
