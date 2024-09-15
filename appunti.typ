// Titolo e indice
#import "template.typ": *

#show: project.with(
  title: "Informatica teorica"
)

#pagebreak()


// Introduzione
#include "capitoli/00_introduzione.typ"
#pagebreak()


// Teoria della calcolabilità
#parte("Teoria della calcolabilità")

#pagebreak()

// Capitoli di teoria della calcolabilità

#include "capitoli/calcolabilità/01_richiami_matematici.typ"
#pagebreak()

#include "capitoli/calcolabilità/02_sistemi_di_calcolo.typ"
#pagebreak()

#include "capitoli/calcolabilità/03_richiami_matematici.typ"
#pagebreak()

#include "capitoli/calcolabilità/04_cardinalità.typ"
#pagebreak()

#include "capitoli/calcolabilità/05_potenza_computazionale.typ"
#pagebreak()

#include "capitoli/calcolabilità/06_dati_NN.typ"
#pagebreak()

#include "capitoli/calcolabilità/07_programmi_NN.typ"
#pagebreak()

#include "capitoli/calcolabilità/08_richiami_matematici.typ"
#pagebreak()

#include "capitoli/calcolabilità/09_calcolabilità.typ"
#pagebreak()

#include "capitoli/calcolabilità/10_sistemi_di_programmazione.typ"
#pagebreak()

#include "capitoli/calcolabilità/11_problemi_decisione.typ"
#pagebreak()

#include "capitoli/calcolabilità/12_riconoscibilità_automatica_insiemi.typ"
#pagebreak()


// Teoria della complessità
#parte("Teoria della complessità")

#pagebreak()

// Capitoli di teoria della complessità

#include "capitoli/complessità/13_richiami_matematici.typ"
#pagebreak()

#include "capitoli/complessità/14_dtm.typ"
#pagebreak()

#include "capitoli/complessità/15_utilizzare_le_dtm.typ"
#pagebreak()

#include "capitoli/complessità/16_richiami_matematici.typ"
#pagebreak()

#include "capitoli/complessità/17_risorsa_tempo.typ"
#pagebreak()

#include "capitoli/complessità/18_risorsa_spazio.typ"
#pagebreak()

#include "capitoli/complessità/19_tempo_vs_spazio.typ"
#pagebreak()

#include "capitoli/complessità/20_zona_grigia.typ"
#pagebreak()

#include "capitoli/complessità/21_ndtm.typ"
#pagebreak()

#include "capitoli/complessità/22_p_vs_np.typ"
#pagebreak()

#include "capitoli/complessità/23_situazione_finale.typ"
