/* AbstractOperator.vala
 *
 * Copyright 2022 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public abstract class DescriptiveStatistics.Operator : Object {
    public unowned SharedData shared_data { get; construct; }
    public Column column { get; construct; }
    public abstract string name { get; }
    public abstract double calculate ();

    public virtual double[] collect_values () {
        int i = column.has_title_row ? 1 : 0;
        double[] values = {};

        for (; i < column.get_n_items (); i++) {
            var row  = (Row) column.get_item (i);
            double? n;
            if (!double.try_parse (row.content, out n)) {
                debug ("Line: %i for column %s is NaN", i, shared_data.title);
                continue;
            }
            assert (n != null);

            values += n;
        }

        return values;
    }
}
