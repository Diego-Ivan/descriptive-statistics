/* ColumnFactory.vala
 *
 * Copyright 2022 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public class DescriptiveStatistics.ColumnBuilder : Object {
    public Separator separator { get; set; default = TAB; }
    private string[] rows = {};

    private bool built { get; set; default = false; }
    public bool use_title_row { get; set; default = false; }

    public ColumnBuilder () {
    }

    public void add_text (string text)
        requires (!built)
    {
        string[] t_rows = text.split ("\n");
        foreach (string row in t_rows) {
            rows += row;
        }
    }

    public ListModel build ()
        requires (!built)
    {
        var model = new ListStore (typeof(Column));

        int n_columns = 0;
        char sep = separator.get_separator ();

        for (int i = 0; i < rows.length; i++) {
            string row = rows[i];
            string[] columns = row.split (sep.to_string ());


            if (i == 0) {
                n_columns = columns.length;
                for (int j = 0; j < columns.length; j++) {
                    model.append (new Column () {
                        has_title_row = use_title_row
                    });
                }
            } else if (columns.length > n_columns) {
                warning ("Row %i has extra columns", i);
                continue;
            }

            for (int j = 0; j < columns.length; j++) {
                var column = (Column) model.get_item (j);
                column.add_row (columns[j]);
            }
        }

        return model;
    }
}
