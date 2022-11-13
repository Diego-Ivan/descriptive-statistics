/* Column.vala
 *
 * Copyright 2022 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public class DescriptiveStatistics.Column : Object, ListModel {
    private List<Row> rows = new List<Row> ();
    public delegate void ForEachRow (Row row);

    public bool has_title_row { get; set; default = false; }

    public Column () {
    }

    public Object? get_object (uint position) {
        return rows.nth_data (position);
    }

    public Object? get_item (uint position) {
        return get_object (position);
    }

    public Type get_item_type () {
        return typeof(Row);
    }

    public void remove_item (uint position) requires (position < rows.length ()) {
        rows.remove (rows.nth_data (position));
    }

    public uint get_n_items () {
        return rows.length ();
    }

    public void add_row (string content) {
        rows.append (new Row (content));
    }

    public void @foreach (ForEachRow func) {
        rows.foreach ((row) => {
            func (row);
        });
    }
}
