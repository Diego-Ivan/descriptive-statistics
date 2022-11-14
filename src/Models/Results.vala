/* Results.vala
 *
 * Copyright 2022 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public class DescriptiveStatistics.Results : Object {
    public string title { get; set; default = ""; }
    public ListModel operation_results { get; set; }

    public Results (string title, ListModel results)
        requires (results.get_item_type () == typeof(Operation))
    {
        Object (
            title: title,
            operation_results: results
        );
    }

    public string to_string () {
        var builder = new StringBuilder ("");
        for (int i = 0; i < operation_results.get_n_items (); i++) {
            var operation = (Operation) operation_results.get_item (i);
            builder.append_printf ("%s\t%s\n", operation.operation, operation.result.to_string ());
        }

        return builder.str;
    }
}
