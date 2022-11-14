/* ResultsList.vala
 *
 * Copyright 2022 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public class DescriptiveStatistics.ResultsList : Gtk.Box{
    public void add_results (Results[] results) {
        empty_box ();

        foreach (var result in results) {
            var page = new ResultPage (result);
            append (page);
        }
    }

    private void empty_box () {
        Gtk.Widget? child = get_first_child ();
        while (child != null) {
            Gtk.Widget? temp = child.get_next_sibling ();
            remove (child);
            child = temp;
        }
    }

    construct {
        orientation = VERTICAL;
        spacing = 12;
    }
}
